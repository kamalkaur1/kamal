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
locals {
 evens   = [for n in var.nums : n if n % 2 == 0]
 squares = [for n in local.evens : n * n]
}
locals {
 initials = toset([for n in var.names : substr(n, 0, 1)])
 grouped  = {
   for i in local.initials :
   i => [for n in var.names : n if substr(n, 0, 1) == i]
 }
}
locals {
Hotels1_upper = [for h in var.Hotels1 : h == "Hyatt" ? upper(h) : h]
}
locals {
  replaced = replace(var.Hotels1, "Hyatt", "HYATT")
}
