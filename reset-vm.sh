#!/bin/bash

pattern=$1
pattern=${pattern:-"remote-*"}

gcloud compute instances list --filter="name:${pattern}" --project=test-va-310803 --format="table[no-heading](name, zone)" | awk '{print $1 " --zone=" $2}' | xargs -n2 gcloud compute instances reset --project=test-va-310803 
