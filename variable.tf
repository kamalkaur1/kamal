variable "subscription_id"{
  type=string
}
variable "client_id"{
  type=string
}
variable "client_secret"{
  type=string
}
variable "tenant_id"{
  type=string
}
variable "firstname"{
type=string 
default ="kamal"
}
variable "lastname"{
type=string 
default ="kaur"
}
variable "restraunt1"{
  type=string
default ="pizzapizza"
}
variable "restraunt2"{
  type=string
default ="pindlasalle"
}
variable "restraunt3"{
  type=string
default ="mcdonald"
}
variable "restraunt4"{
  type=string
default ="harvey"
}
variable "restraunt5"{
  type=string
default ="periperi"
}
variable "millenialyear"{
  type=number
default =2000
}
variable "truefalse"{
  type=bool
default =false
}
variable "list" {
  type    = list(string)
  default = ["hello", "class", "MCIT"]
}
variable "colors" {
  type    = list(string)
  default = ["red", "yellow", "blue","pink", "black"]
}
variable "listoffruits"{
  type    = list(string)
  default = ["apple", "mango", "avacado","banana", "blueberries"]
}
variable "listoffoods" {
  type    = list(string)
  default = ["macroni", "pizza", "pasta"]
}
variable "listoftravel" {
  type    = list(string)
  default = ["UK", "Australia", "USA"]
}
variable "listoficecream" {
  type    = list(string)
  default = ["vanilla", "strawberry", "rasberryflavor"]
}
variable "affirmationstrong" {
    type        = bool
  default     = true
}
variable "affirmationstupid" {
    type        = bool
  default     = false
}
variable"appname" {
 type        = string
  default      ="cloudapp"
}
variable "items" {
  type    = list(string)
  default = ["one", "two", "three"]
}
variable "server_name" {
  type    = string
  default = "app-prod-01"
}
variable "activities" {
  type    = list(string) 
  default = ["watchingtv", "listeningmusic", "cooking"]
}
variable "movies" {
  type    = string
  default = "DDLJ-JATTANDJULIET-TIGER"
}
variable "movie" {
  default = "Inception"
}
variable "original" {
 type    = string
  default = "Hello MCIT World"
}
 variable "replaced" {
 type    = string
  default = "CLOUDCLASS"
}
variable "labels" {
 type    = set(string)
 default = ["alpha", "beta", "gamma"]
}

variable "phrase" {
  default = "InceptionMovie"
}
variable "domain" {
 type    = string
 default = "example.com"
}
variable "raw_scores" {
 type    = list(string)
 default = ["alice:90", "bob:75", "carol:85"]
}
variable "items1" {
 type    = list(string)
 default = ["b", "a", "c", "a", "b"]
}
variable "nums" {
 type    = list(number)
 default = [1,2,3,4,5,6]
}
variable "names" {
 type    = list(string)
 default = ["amy", "adam", "bob", "brian", "carol"]
}
variable "words" {
 type    = list(string)
 default = ["hi", "cat", "car", "tree", "hi", "car"]
}
variable "raw_scores" {
 type    = list(string)
 default = ["alice:90", "bob:75", "carol:85"]
}

 
