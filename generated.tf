# Generated -------------------------------------
# -----------------------------------------------
# Sometimes, you gotta take the shortcut (?!)

resource "local_file" "python_cloud_run_http_main_py" {
  filename = "${path.module}/generated/main.py"

  content = <<-PYTHON
    import functions_framework

    @functions_framework.http
    def hello_http(request):
        return {"message": "Hello from outta space!"}
  PYTHON
}

resource "local_file" "python_cloud_run_http_requirements" {
  filename = "${path.module}/generated/requirements.txt"
  content  = "functions-framework==3.*\n"
}

data "archive_file" "python_cloud_run_zip" {
  type        = "zip"
  source_dir  = "${path.module}/generated"
  output_path = "${path.module}/cloud-run-function.zip"

  depends_on = [
    local_file.python_cloud_run_http_main_py,
    local_file.python_cloud_run_http_requirements
  ]
}
