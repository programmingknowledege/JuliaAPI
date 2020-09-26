

function Register(username,password,emailid,phonenumber)
    bson = Mongoc.find_one(collection,Mongoc.BSON("username"=>username))
    if(bson==nothing)   
        document=Mongoc.insert_one(collection,Mongoc.BSON("username" => username, "password" => password, 
        "emailid" =>emailid,"phonenumber"=>phonenumber))
        if(document==nothing)
            return false
        else
            return true
        end     
    else
        "User Name should be unique"    
    end    
end


function Login(username,password)
    bson = Mongoc.find_one(collection,Mongoc.BSON("username"=>username,"password"=>password))
    if(bson==nothing)
        return false
    else
        return true
    end    
end

    

function changepassword(username,password,changepassword)
    bson = Mongoc.find_one(collection,Mongoc.BSON("username"=>username,"password"=>password))
    if(bson==nothing) 
        return false 
    else
        selector=Mongoc.BSON("username"=>username,"password" => password)
        update=Mongoc.BSON("""{"\$set":{"password":"$changepassword"}}""")
        document=Mongoc.update_one(collection,selector,update)
        return true
    end    
end    

function forgetpassword(username,password)
    bson=Mongoc.find_one(collection,Mongoc.BSON("username"=>username))
    if(bson==nothing)
        return false
    else
        selector=Mongoc.BSON("username"=>username)
        update=Mongoc.BSON("""{"\$set":{"password":"$password"}}""")
        document=Mongoc.update_one(collection,selector,update)
        return true
    end
end

function addrole(rolename,rolepermission)
    document=Mongoc.insert_one(collectionrole,Mongoc.BSON("rolename"=>rolename,"rolepermission"=>rolepermission))
    if(document!=nothing)
        return true
    else
        return false   
    end
end

function getuserinfo()
    collections=Mongoc.find(collection)
    return collections   
end

function deleteuserrole(username,rolename)
    usersearch=Mongoc.find_one(collection,Mongoc.BSON("username"=>username,"rolename"=>rolename))
    if(usersearch==nothing)
        return false
    else
        document=Mongoc.update_one(collection,Mongoc.BSON("username"=>username),Mongoc.BSON("""{"\$unset":{"rolename":""}}"""))
        if(document==nothing)
            return false
        else
            return true    
        end      
    end
end

function adduserrole(username,rolename)
    usersearch=Mongoc.find_one(collection,Mongoc.BSON("username"=>username))
    if(usersearch==nothing)
        return false
    else
        rolenamesearch=Mongoc.find_one(collectionrole,Mongoc.BSON("rolename"=>rolename))
        if(rolenamesearch==nothing)
            return false
        else 
            document=Mongoc.update_one(collection,Mongoc.BSON("username"=>username),Mongoc.BSON("""{"\$set":{"rolename":"$rolename"}}"""))
            if(document==nothing)
                return false
            else 
                return true
            end        
        end     
    end
end


function deleterole(username,rolename)
    rolesearch=Mongoc.find_one(collectionrole,Mongoc.BSON("rolename"=>rolename))
    if(rolesearch==nothing)
        return false
    else
        document=Mongoc.delete_one(collectionrole,Mongoc.BSON("rolename"=>rolename))
        if(document!=nothing)
            usersearch=Mongoc.find_one(collection,Mongoc.BSON("username"=>username,"rolename"=>rolename))
            for i in usersearch
                document=Mongoc.update_one(collection,Mongoc.BSON("username"=>username,"rolename"=>rolename),
                Mongoc.BSON("""{"\$unset":{"rolename":""}}"""))
                   
            end
        end

    end
end


