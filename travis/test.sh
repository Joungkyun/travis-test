#!/bin/bash

# add udf

if [ -f "../docs/aes256_install.sql" ]; then
	mysql -u root < ../docs/aes256_install.sql
else
	mysql -u root < ./docs/aes256_install.sql
fi

[ $? -ne 0 ] && echo "Failed registration UDF" > /dev/stdout && exit 1

KEY="0123456789abcdef0123456789abcdef"

enc=$(mysql -u root -e "select HEX(AES256_ENCRYPT(\"asdf\", \"${KEY}\"))" | tail -n 1)
dec=$(mysql -u root -e "select AES256_DECRYPT(UNHEX(\"${enc}\"), \"${KEY}\")" | tail -n 1)

if [ "${dec}" = "asdf" ]; then
	echo "Pass: aes256 encrypt and decrypt"
else
	echo "Failed: aes256 encrypt and decrypt"
	exit 1
fi

exit 0
