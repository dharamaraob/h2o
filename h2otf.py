#!/usr/bin/python3
import argparse
import os

def init():
    print("Initialization")
    os.system('terraform init -backend-config="./backend.config"')

def plan():
    print("Plan")
    os.system('terraform plan -var-file="var.tfvars" -out ins')

def apply():
    print("apply")
    os.system('terraform apply ins')

def destroy():
    print("destroy")
    os.system('terraform destroy -var-file="var.tfvars"')


parser = argparse.ArgumentParser(description='Process terrafrom cluster.')
parser.add_argument('--cmd',
                    help='Require init or plan or apply or destroy' ,required=True, choices=['init', 'plan', 'apply','destroy'])

args = parser.parse_args()
if args.cmd == "init":
    init()
elif args.cmd == "plan":
    plan()
elif args.cmd == "apply":
    apply()
elif args.cmd == "destroy":
    destroy()
