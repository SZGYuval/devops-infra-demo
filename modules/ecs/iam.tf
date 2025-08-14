resource "aws_iam_role" "ecs_task_execution" {
  name = "${var.cluster_name}-exec-role"
  assume_role_policy = file("${path.module}/iam_policies/exec_trust.json")
}

resource "aws_iam_policy" "ecs_task_execution_permissions" {
  name = "${var.cluster_name}-task-defenition-policy"
  policy = file("${path.module}/iam_policies/task_defenition.json")
}

resource "aws_iam_role_policy_attachment" "ecs_exec_attach" {
  role = aws_iam_role.ecs_task_execution.name
  policy_arn = aws_iam_policy.ecs_task_execution_permissions.arn
}