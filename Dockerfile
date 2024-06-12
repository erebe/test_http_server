FROM hashicorp/terraform:1.8.5

RUN apk update && apk add dumb-init && mkdir /data

WORKDIR /data

RUN cat <<EOF > entrypoint.sh
#!/bin/sh

CMD=\$1; shift

cd terraform
terraform init

set -ex

case "\$CMD" in
start)
  echo 'start command invoked'
  terraform plan -input=false -out plan.tf
  terraform apply -input=false -auto-approve plan.tf
  ;;

stop)
  echo 'stop command invoked'
  ;;

delete)
  echo 'delete command invoked'
  terraform plan -destroy -out plan.tf -input=false
  terraform apply -destroy -auto-approve -input=false plan.tf
  ;;

plan)
  echo 'plan command invoked'
  terraform plan \$1 \$2 \$3 \$4 \$5 \$6 \$7 \$8 \$9
  ;;

debug)
  echo 'debug command invoked. sleeping for 9999999sec'
  echo 'Use remote shell to connect and execute commands'
  sleep 9999999999
  exit 1
  ;;

*)
  echo "Command not handled by entrypoint.sh: '\$CMD'"
  exit 1
  ;;
esac

EOF

COPY . terraform

RUN <<EOF
chmod +x entrypoint.sh
cd terraform
terraform init -backend=false
EOF

ENV AWS_DEFAULT_REGION=must-be-set-as-env-var
ENV AWS_ACCESS_KEY_ID=must-be-set-as-env-var
ENV AWS_SECRET_ACCESS_KEY=must-be-set-as-env-var
ENV JOB_INPUT=xxx


ENTRYPOINT ["/usr/bin/dumb-init", "-v", "--", "/data/entrypoint.sh"]
CMD ["start"]
