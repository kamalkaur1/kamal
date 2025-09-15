output "firstoutput"{
value=var.firstname
}
output "lastoutput"{
  value=var.lastname
}
output  "restraunttoutput1"{
value=var.restraunt1
}
output  "restraunttoutput2"{
value=var.restraunt2
}
output  "restraunttoutput3"{
value=var.restraunt3
}
output  "restraunttoutput4"{
value=var.restraunt4
}
output  "restraunttoutput5"{
value=var.restraunt5
}
output  "millenialyear"{
value=var.millenialyear
}
output  "booleanoutput"{
value=var.truefalse
}
output  "list"{
value=var.list
}
output  "listoffruits"{
value=var.listoffruits
}
output  "listoftravel"{
value=var.listoftravel
}
output  "listoficecream"{
value=var.listoficecream
}
output  "colors"{
value=var.colors
}
output  "affirmationstrong"{
value=var.affirmationstrong
}
output  "affirmationstupid"{
value=var.affirmationstupid
}
output  "application_name"{
value=local.fullname
}
output "csv_items" {
  value = join(",", var.items)
}
output "server_name_parts" {
  value = split("-", var.server_name)
}
output "activities" {
  value = join(",", var.activities)
}
