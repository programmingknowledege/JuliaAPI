using JSON
using JSONWebTokens
using Genie, Genie.Router, Genie.Renderer.Json, Genie.Requests
using Mongoc

client = Mongoc.Client()
print(Mongoc.ping(client))
database = client["LearnMOngodb"]  
collection = database["testCollection"]
collectionrole=database["role"]


include("../Practice/controller/usercontroller.jl")


route("/register",registercontroller,method=POST)
route("/login",logincontroller,method=POST)
route("/changepassword",changepasswordcontroller,method=POST)
route("/forgetpassword",forgetpasswordcontroller,method=POST)
route("/addrole",addrolecontroller,method=POST)
route("/getuserinfo",getuserinfocontroller,method=GET)
route("/deleteuserrole",deleteuserrolecontroller,method=POST)
route("/adduserrole",adduserrolecontroller,method=POST)
route("/deleterole",deleterolecontroller,method=POST)

up(async=false)