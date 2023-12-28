#!/bin/bash

run_unix_cmd() {
  # $1 is the line number
  # $2 is the cmd to run
  # $3 is the expected exit code
  output=`$2 2>&1`
  exit_code=$?
  if [[ $exit_code -ne $3 ]]; then
    printf "failed (incorrect exit status code) on line $1.\n"
    printf "  - exit code: $exit_code (expected $3)\n"
    printf "  - command: $2\n"
    if [[ -z $output ]]; then
      printf "  - output: <none>\n\n"
    else
      printf "  - output: <starts on next line>\n$output\n\n"
    fi
    exit 1
  fi
}

printf "Testing ietf-tcp-client (pyang)..."
command="pyang -Werror --ietf --max-line-length=69 -p ../ ../ietf-tcp-client\@*.yang"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

printf "Testing ietf-tcp-client (yanglint)..."
command="yanglint -p ../ ../ietf-tcp-client\@*.yang"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

printf "Testing ietf-tcp-server (pyang)..."
command="pyang -Werror --ietf --max-line-length=69 -p ../ ../ietf-tcp-server\@*.yang"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

printf "Testing ietf-tcp-server (yanglint)..."
command="yanglint -p ../ ../ietf-tcp-server\@*.yang"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

printf "Testing ietf-tcp-common (pyang)..."
command="pyang -Werror --ietf --max-line-length=69 -p ../ ../ietf-tcp-common\@*.yang"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

printf "Testing ietf-tcp-common (yanglint)..."
command="yanglint -p ../ ../ietf-tcp-common\@*.yang"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

printf "Testing ex-tcp-client.xml..."
name=`ls -1 ../ietf-tcp-client\@*.yang | sed 's/\.\.\///'`
sed 's/^}/container tcp-client { uses tcp-client-grouping; }}/' ../ietf-tcp-client\@*.yang > $name
command="yanglint ../ietf-tcp-common@*.yang $name -p ../ ex-tcp-client.xml"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"
rm $name

printf "Testing ex-tcp-client-proxy.xml..."
name=`ls -1 ../ietf-tcp-client\@*.yang | sed 's/\.\.\///'`
sed 's/^}/container tcp-client { uses tcp-client-grouping; }}/' ../ietf-tcp-client\@*.yang > $name
command="yanglint ../ietf-crypto-types@*.yang ../ietf-tcp-common@*.yang $name ex-tcp-client-proxy.xml"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"
rm $name

printf "Testing ex-tcp-server.xml..."
name=`ls -1 ../ietf-tcp-server\@*.yang | sed 's/\.\.\///'`
sed 's/^}/container tcp-server { uses tcp-server-grouping; }}/' ../ietf-tcp-server\@*.yang > $name
command="yanglint ../ietf-tcp-common@*.yang $name -p ../ ex-tcp-server.xml"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"
rm $name

printf "Testing ex-tcp-common.xml..."
name=`ls -1 ../ietf-tcp-common\@*.yang | sed 's/\.\.\///'`
sed 's/^}/container tcp-common { uses tcp-common-grouping; }}/' ../ietf-tcp-common\@*.yang > $name
command="yanglint $name ex-tcp-common.xml"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"
rm $name

