aws ec2 create-key-pair --key-name aws-gbs-cli --key-type rsa --query 'KeyMaterial' --output text | out-file -encoding ascii -filepath ~/.ssh/aws-gbs-cli.pem

aws ec2 create-security-group --group-name gbs-sec-group --description "Phishing-Server"
aws ec2 authorize-security-group-ingress --group-name gbs-sec-group --protocol tcp --port 5000 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-name gbs-sec-group --protocol tcp --port 22 --cidr 0.0.0.0/0

aws secretsmanager create-secret --name PhishingServerPwd --secret-string [myPwd]

aws ec2 run-instances --image-id ami-08c40ec9ead489470 --count 1 --instance-type t2.micro --key-name aws-gbs-cli --security-groups gbs-sec-group --iam-instance-profile Name=LabInstanceProfile --user-data [PfadZurPhishing-Server-Init Text-File]