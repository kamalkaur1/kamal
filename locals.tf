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
locals {
 emails = { for u in var.usernames : u => "${u}@${var.domain}" }
}
locals {
 unique_sorted = sort(distinct(var.items1))
 csv           = join(",", local.unique_sorted)
}



