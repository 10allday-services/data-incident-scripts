package main

import (
	"bufio"
	"context"
	"fmt"
	"log"
	"os"
	"strings"
	"sync"

	"github.com/aws/aws-sdk-go-v2/aws/external"
	"github.com/aws/aws-sdk-go-v2/service/s3"
)

const numWorkers = 2048

var (
	sourceBucket = "net-mozaws-prod-us-west-2-pipeline-data"
	backupBucket = "net-mozaws-prod-us-west-2-pipeline-data-test"
)

func main() {
	cfg, err := external.LoadDefaultAWSConfig()
	if err != nil {
		log.Fatalln(err)
	}

	file, err := os.Open(os.Args[1])
	if err != nil {
		log.Fatalln(err)
	}
	defer file.Close()

	inputs := make(chan *s3.CopyObjectInput)
	go func() {
		scanner := bufio.NewScanner(file)
		for scanner.Scan() {
			fields := strings.Fields(scanner.Text())
			_, key := fields[2], fields[3]
			source := fmt.Sprintf("/%s/%s", sourceBucket, key)

			input := &s3.CopyObjectInput{
				Bucket:     &backupBucket,
				Key:        &key,
				CopySource: &source,
			}

			inputs <- input
		}
		close(inputs)
	}()

	svc := s3.New(cfg)

	var workerWG sync.WaitGroup
	workerWG.Add(numWorkers)
	for i := 0; i < numWorkers; i++ {
		go func() {
			defer workerWG.Done()

			for input := range inputs {
				_, err := svc.CopyObjectRequest(input).Send(context.Background())
				if err != nil {
					log.Panicln(err)
				}

				fmt.Println("copied " + *input.Key)
			}
		}()
	}

	workerWG.Wait()
}
