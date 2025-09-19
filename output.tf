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
output "MOVIES" {
  value = split("-", var.movies)
}
output  "displaylower"{
value=local.movie_lower
}
output  "displayupper"{
value=local.movie_upper
}
output "original" {
  value = local.replaced
}
output "first_word" {
  value = local.first_word # "Inception"
}
output "labels_upper" {
 value = local.labels_upper
}
output "emails" {
 value = local.emails
}
output "unique_sorted" { value = local.unique_sorted }
output "csv"           { value = local.csv }
output "evens"   { value = local.evens }
output "squares" { value = local.squares }
output "grouped_by_initial" { value = local.grouped }
output "Hotels1" {
  value = [for word in var.Hotels1 : (word == "Hyatt" ? upper(word) : word)]
}
output "activities1" {
value = join(" → ", var.activities1)
}
output "rname" {
  value = replace(
    replace(
      replace(
        replace(
          replace(Marriot, "a", "*"),
          "e", "*"
        ),
        "i", "*"
      ),
      "o", "*"
    ),
    "u", "*"
  )
}

