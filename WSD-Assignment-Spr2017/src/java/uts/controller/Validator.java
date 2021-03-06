/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.controller;

import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author George
 */
public class Validator {
    private String emailPattern = "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4}";   
    private String namePattern = "([A-Z][a-z]+[\\s])+[A-Z][a-z]*";    
    private String passwordPattern = "[a-z]{8,}[0-9]+";    
    private HashMap<String,String> errors = new HashMap();
    
    public Validator(){  }
    
    public void add(String key, String err){
        errors.put(key, err);
    }
    
    public boolean validate(String pattern, String input){
        Pattern regEx = Pattern.compile(pattern);
        Matcher match = regEx.matcher(input);
        return match.matches();
    }
    
    public boolean checkEmpty(String email, String name, String password){
        return password == null || name==null || null == email || name.isEmpty() || email.isEmpty() || password.isEmpty();
    }
    public boolean validateEmail(String email){                
        return validate(emailPattern,email);
    }
    
    public boolean validateName(String name){        
        return validate(namePattern,name);
    }
    
    public boolean validatePassword(String password){        
        return validate(passwordPattern,password);
    }
    
    public boolean testOption(String type){
        return type != null;
    }
    
    public HashMap errors(){
        return errors;
    }
    
    public void clearLogs(){
        errors.clear();
    }
    
    public String error(String key){
        
        for(Map.Entry<String,String> e:errors.entrySet()){
            if(e.getKey().equals(key))
                return e.getValue();
        }
        return null;
    }    
    
    public boolean test_edit(String name, String password, String dob){
        return name!=null && password != null && dob != null;
    }
    
}
