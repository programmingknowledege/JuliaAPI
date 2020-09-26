include("../model/usermodel.jl")
using Genie, Genie.Router, Genie.Requests, Genie.Renderer.Json
using Mongoc
using HTTP
function registercontroller()
    try 
        username=jsonpayload()["username"]
        password=jsonpayload()["password"]
        emailid=jsonpayload()["emailid"]
        phonenumber=jsonpayload()["phonenumber"]
        data=Register(username,password,emailid,phonenumber)
        print(data)
        if(data==true)
            return HTTP.Response(200,JSON.json(Dict("Message"=>"Data Inserted Successfully")))
        else
            return HTTP.Response(200,JSON.json(Dict("Message"=>"Data Not Inserted Successfully")))
        end
    catch
        return HTTP.Response(500,JSON.json(Dict("Message"=>"Internal Server Error")))   
    end    
end    

function logincontroller()
    try 
        username=jsonpayload()["username"]
        password=jsonpayload()["password"]
        data=Login(username,password)
        if(data==true)
            return HTTP.Response(200,JSON.json(Dict("Message"=>"Data Login Successfully")))
        else
            return HTTP.Response(200,JSON.json(Dict("Message"=>"Data Not Login Successfully")))
        end
    catch
        return HTTP.Response(500,JSON.json(Dict("Message"=>"Internal Server Error")))   
    end    
end  
    

function changepasswordcontroller()
    username=jsonpayload()["username"]
    password=jsonpayload()["password"]
    changepasswordd=jsonpayload()["changepassword"]
    data=changepassword(username,password,changepasswordd)
    if(data==true)
        return HTTP.Response(200,JSON.json(Dict("Message"=>"ChangedPassword Successfully")))
    else
        return HTTP.Response(200,JSON.json(Dict("Message"=>"ChangedPassword Not Successfully")))
    end
end

function forgetpasswordcontroller()
    try
        username=jsonpayload()["username"]
        password=jsonpayload()["password"]
        data=forgetpassword(username,password)
        if(data==true)
            return HTTP.Response(200,JSON.json(Dict("Message"=>"ChangedPassword Successfully")))
        else
            return HTTP.Response(200,JSON.json(Dict("Message"=>"ChangedPassword Not Successfully")))
        end        
    catch
        return HTTP.Response(500,JSON.json(Dict("Message"=>"Internal Server Error"))) 
    end  
end


function addrolecontroller()
    try
        rolename=jsonpayload()["rolename"]
        rolepermission=jsonpayload()["rolepermission"]
        data=addrole(rolename,rolepermission)
        if(data==true)
            return HTTP.Response(200,JSON.json(Dict("Message"=>"ChangedPassword Successfully")))
        else
            return HTTP.Response(200,JSON.json(Dict("Message"=>"ChangedPassword Not Successfully")))
        end
    catch
        return HTTP.Response(500,JSON.json(Dict("Message"=>"Internal Server Error"))) 
    end
end

function getuserinfocontroller()
    try
        data=getuserinfo()
        for i in data
            println(i)
        end 
    catch
        return HTTP.Response(500,JSON.json(Dict("Message"=>"Internal Server Error")))
    end
end


function deleteuserrolecontroller()
    try
        username=jsonpayload()["username"]
        rolename=jsonpayload()["rolename"]
        data=deleteuserrole(username,rolename)
        if(data==true)
            return HTTP.Response(200,JSON.json(Dict("Message"=>"User with that role Deleted Successfully")))
        else
            return HTTP.Response(200,JSON.json(Dict("Message"=>"No Such Username or role found")))
        end
    catch
        return HTTP.Response(500,JSON.json(Dict("Message"=>"Internal Server Error")))
    end    
end


function adduserrolecontroller()
    try
        username=jsonpayload()["username"]
        rolename=jsonpayload()["rolename"]
        data=adduserrole(username,rolename)
        if(data==true)
            return HTTP.Response(200,JSON.json(Dict("Message"=>"Role Added Successfully")))
        else
            return HTTP.Response(200,JSON.json(Dict("Message"=>"User Name and Role Not Found")))
        end
    catch
        return HTTP.Response(500,JSON.json(Dict("Message"=>"Internal Server Error")))
    end
end

function deleterolecontroller()
    try
        username=jsonpayload()["username"]
        rolename=jsonpayload()["rolename"]
        data=deleterole(username,rolename)
        if(data==false)
           return HTTP.Response(200,JSON.json(Dict("Message"=>"User Name and Role Not Found")))
        end
    catch
        return HTTP.Response(500,JSON.json(Dict("Message"=>"Internal Server Error")))
    end
end