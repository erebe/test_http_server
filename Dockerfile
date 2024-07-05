FROM hashicorp/terraform:1.8.5

RUN <<EOF
set -e
apk update
apk add dumb-init
adduser -D app
mkdir /data
chown -R app:app /data
EOF

WORKDIR /data
USER app

RUN cat <<EOF > entrypoint.sh
#!/bin/sh

if [ "\$JOB_INPUT" != '' ]
then
  TF_VARS="\$JOB_INPUT"
fi

CMD=\$1; shift
set -ex

cd terraform
terraform init -backend-config="secret_suffix=qovery-\${QOVERY_JOB_ID}" -backend-config="namespace=\${QOVERY_KUBERNETES_NAMESPACE_NAME}" -backend-config="lol=qovery-\${QOVERY_JOB_ID}"

case "\$CMD" in
start)
  echo 'start command invoked'
  terraform plan -input=false -out=tf.plan -var-file=\$TF_VARS
  terraform apply -input=false -auto-approve tf.plan
  ;;

stop)
  echo 'stop command invoked'
  exit 0
  ;;

delete)
  echo 'delete command invoked'
  terraform plan -destroy -out=tf.plan -input=false -var-file=\$TF_VARS
  terraform apply -destroy -auto-approve -input=false tf.plan
  ;;

raw)
  echo 'raw command invoked'
  terraform "\$1" "\$2" "\$3" "\$4" "\$5" "\$6" "\$7" "\$8" "\$9"
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

COPY --chown=app:app . terraform

RUN <<EOF
set -e
chmod +x entrypoint.sh
cd terraform
terraform init -backend=false
EOF

ENV TF_VARS=must-be-set-as-env-var-file
#ENV JOB_OUPUT=/mnt/data/terraform.tfvars


ENTRYPOINT ["/usr/bin/dumb-init", "-v", "--", "/data/entrypoint.sh"]
CMD ["start"]
