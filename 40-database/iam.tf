resource "aws_iam_role" "mysql" {
    name = "${local.common_name}-mysql" #roboshop-dev-mysql

    #This is the trust policy, means we can attach this role to EC2 instance
    assume_role_policy = jsoncode ({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
})

tags = merge(
    {
        Name = "${local.common_name}-mysql"
    },
    local.common_tags
) 

}


resource "aws_iam_policy" "mysql" {
    name = "${local.common_name}-mysql" #roboshop-dev-mysql

    #Terraform's "jsoncode" function converts a
    #Terraform expression result to valid JSON syntax

    policy = file("mysql-iam-policy.json")

}

resource "aws_iam_role_policy_attachment" "mysql" {
    role        = aws_iam_role.mysql.name
    policy_arn  = aws_iam_policy.mysql.arn
}

resource "aws_iam_instance_profile" "mysql" {
    name        = "${local.common_name}-mysql"
    role        = aws_iam_role.mysql.name
}
