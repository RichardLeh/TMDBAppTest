//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var varTeste = "123"

func withParameter(_ teste: inout String){
    print(teste)
    
    teste = teste + "000"
    var teste2 = teste
    teste2 = teste2 + "456"
    
    print(teste2)
}

withParameter(&varTeste)
print(varTeste)

var la = ""

func getQuestionList(_ language: String) -> String {
    var lang = language
    if lang.isEmpty {
        lang = "NL"
        
        return lang
    }
    
    return lang
}

var laa = getQuestionList(la)

print(la)
print(laa)
