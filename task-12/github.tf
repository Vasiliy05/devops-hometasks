
resource "github_repository_file" "file" {
  count = length(var.list_of_files)

  repository = var.repo_name
  branch = "master"
  file = "task-12/${element(var.list_of_files, count.index)}"
  content = file("${path.cwd}/${element(var.list_of_files, count.index)}")
  commit_message = "files for task-12"
  overwrite_on_create = true
}