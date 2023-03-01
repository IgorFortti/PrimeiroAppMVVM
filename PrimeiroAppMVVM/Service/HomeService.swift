//
//  HomeService.swift
//  PrimeiroAppMVVM
//
//  Created by Igor Fortti on 20/02/23.
//

import UIKit

//O alamofire simplica as requisicoes de api.
import Alamofire
import SwiftUI

enum ErrorDetail: Swift.Error {
    case errorURL(urlString: String)
    case detailError(detail: String)
}

// Essa classe será responsáveis por implementar os servicos do app. Os Servicoes sao as requisicoes de API e também
// utilizacao/leitura de dados de um arquivo Json (Mock).

class HomeService {
//MARK: REQUISICAO DE FORMA NATIVA COM URLSESSION
    
    
    func getHomeDataURLSession(completion: @escaping (HomeData?, Error?) -> Void) {
//        Criamos na constante urlString, a nossa url, informando a url onde estão os nossos dados.
        let urlString: String = "https://run.mocky.io/v3/10f27af0-d6d3-4420-9633-3b8345fc405a"
//        Aqui, fazemos o guardlet para tiraros a opcionalidade da nossa url. Portanto, nossa url definitica ficará salva na constante url.
        guard let url: URL = URL(string: urlString) else { return completion(nil, ErrorDetail.errorURL(urlString: urlString)) }
//        Aqui estamos criando a nossa requsicao e armazenando ela na variavel request. informamos a url de onde será requisitado e depois em httmmethod o tipo de requsicao que nesse caso é de consulta.
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
//          Aqui estamos executando de fato a requisicao, na constante task.
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//           Com o guard let abaixo remevemos a opcionalidade do data e em caso de ele existir, será guardando na constante dataResult.
            guard let dataResult = data else {
                return completion(nil, ErrorDetail.detailError(detail: "Error Data"))}
//            Aqui criamos a constante json para tentar transformar o nosso dataResult que é do tipo binário em um json para podermos printar ele.
            let json = try? JSONSerialization.jsonObject(with: dataResult, options: [])
            print(json as Any)
//            Aqui estamos removendo a opcionalidade do nosso response e tratando ele como do tipo HTTPURLRESPONSE para conseguirmos acessar o método statusCode.
            guard let response = response as? HTTPURLResponse else { return }
// Aqui estamos fazendo um IF para continuarmos com a decodificacao dos dados armazenados em dataResult somente se o response for igual a 200. Esse é o código de quando não há erro na comunicacao com o servidor. Na chave verdadeira do IF faremos o doCatch para tentar decodificar os dados binários em data result. Na chave falsa (else), informamos com o print o erro e retornamos no completion nil para homeData e o error da nossa constant task no Error.
            if response.statusCode == 200 {
//                Dentro da chave verdadeira do IF, estamos fazendo um docatch para tentarmos fazer a decodificacao dos dados que estao em tipo binário dentro de dataResult, para o tipo HomeData, que é o tipo do nosso objeto Em caso de conseguirmos, printaos a nossa funcao e passamos no completion a nossa constante criada homeData no HomeData e nil no Error. No catch, que é o do contrário, printamos a funcao e passamos nil no homeData do completion e a constante error da nossa task no Error.
                do {
                    let homeData: HomeData = try JSONDecoder().decode(HomeData.self, from: dataResult)
                    completion(homeData, nil)
                    print("SUCCESS -> \(#function)")
                } catch {
                    print("ERROR -> \(#function)")
                    completion(nil, error)
                }
            } else {
                print("ERROR -> \(#function)")
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    
//MARK: REQUISICAO COM ALAMOFIRE
//    O @escaping no completion informa que o método deverá permacecer ativo o tempo que for preciso até receber o retorno dos dados que ele está requisitando de um servidor. Dessa forma a funcao saberá que o recebimento dos dados será feito de maneira assincrona. Nesse caso, usando o alamofire, estamos fazendo de fato uma requisicao.
    func getHomeDataAlamofire(completion: @escaping (HomeData?, Error?) -> Void) {
//        Abaixo estamos criando uma constante do tipo String para armazenar a URL onde vamos requisitar os nossos dados.
        let url: String = "https://run.mocky.io/v3/10f27af0-d6d3-4420-9633-3b8345fc405a"
//        Abaixo estamos fazendo de fato a nossa requisicao e já estamos decodificando ela em um objeto do tipo Home Self.
        AF.request(url, method: .get).validate().responseDecodable(of: HomeData.self) { response in
//            Aqui é feito um print do response por inteiro
            debugPrint(response)
//            Esse switch serve para nos dar retornar diferentes em caso de sucesso ou erro na requisicao.
            switch response.result {
            case .success( let success):
                print("SUCCESS -> \(#function)")
                completion(success, nil)
            case .failure( let error):
                print("ERROR -> \(#function)")
                completion(nil, error)
            }
        }
    }
    
    
//MARK: MOCK - LEITURA DE DADOS DE UM ARQUIVO JSON DENTRO DO PROJETO
    // O @escaping no completion informa que o método deverá permacecer ativo o tempo que for preciso até receber o retorno dos dados que ele está requisitando de um servidor. Dessa forma a funcao saberá que o recebimento dos dados será feito de maneira assincrona. No caso em questao, com o arquivo json dentro d o projeto a leitura dos dados será feito de forma imediata, visto que eles já estão disponíveis dentro do projeto.
    func getHomeDataJson(completion: @escaping (HomeData?, Error?) -> Void) {
//        Aqui buscamos a URL, o local onde estão os nossos dados.
        if let url = Bundle.main.url(forResource: "HomeData", withExtension: "json") {
            do {
//                Aqui estamos tentando transformar os dados acessados na url informada em um tipo binário.
                let data = try Data(contentsOf: url)
//                Aqui é criacao de um objeto do tipo da nossa struct com o modelo dos dados que precisamos. No Try estamos fazendo o decode, ou seja, tentando transformar aquele nosso dado que está em um tipo binário para o tipo que criamos para o nosso objeto. Para isso ser possível, o objeto que críamos para receber o json precisa estar de acordo com o protocolo decodable
                let homeData: HomeData = try JSONDecoder().decode(HomeData.self, from: data)
//                Em caso de suceso na tentativas acima o completion abaixo retorna homeData para o que esperamos como HomeData. No catch, fazemos o do contrário, que retornará nil para o que esperamos como HomeData e retornará error para o que esperamos como erro.
                completion(homeData, nil)
            } catch {
                completion(nil, error)
            }
        }
    }
}
