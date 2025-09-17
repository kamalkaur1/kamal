locals {  
 fullname="${var.appname}-prod"
 }
locals {
  movie_lower = lower(var.movie) # "inception"
  movie_upper = upper(var.movie) # "INCEPTION"
}
locals {
  replaced = replace(var.original, "MCIT", "Montreal College")
}
 
output "replaced_string" {
  value = local.replaced 
}
locals {  
first_word=substr(var.phrase,0,9)# start at index0 ,length9
}
locals {
 labels_upper = toset([for s in var.labels : upper(s)])
}
variable "usernames" {
 type    = list(string)
 default = ["alice", "bob", "carol"]
}

