variable "project" { 
  description = "Project name" 
  default = "DefaultProjectName"
}

/* example 
map( "us-east-1", list("a", "b", "c"), 
     "us-west-1", list("b", "c", "d")) 
*/
variable "structure" {
  description = "Project structure"
  type = "list"
}

data "template_file" "init" {
    template = "$${structure}"

    vars {
        structure = "${var.structure}"
    }
}
