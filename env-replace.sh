#!/bin/bash

sed -i 's/\$AWS_IP/'"$AWS_IP"'/g' backend/.env frontend/.env.local
