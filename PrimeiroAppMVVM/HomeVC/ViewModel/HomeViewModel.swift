//
//  HomeViewModel.swift
//  PrimeiroAppMVVM
//
//  Created by Igor Fortti on 16/02/23.
//

import UIKit

protocol HomeViewModelProtocol: AnyObject {
    func success()
    func error()
}

// Essa é a classe que contém toda a parte lógica para a view Home. Aqui ela se comunica com o model e instancia os objetos para serem apresentados na tela pela controller.
class HomeViewModel {
    
    private var service: HomeService = HomeService()
    private var posts = [Posts]()
// Variavel para guardar o array que populara a celula da collection esquerda. O Array instancia uma classe que é o nosso model. Esse model define nas propriedades caracteríticas dos objetos que estão sendo criados. É criada como private para que a view nao possa executar nada no array. A view precisa dos resultados prontos.
    private var story = [Stories]()
    
    private weak var delegate: HomeViewModelProtocol?
    
    public var getListPosts: [Posts] {
        posts
    }
    
    public func delegate(delegate: HomeViewModelProtocol?) {
        self.delegate = delegate
    }
    
//    Variável computada que que permite acesso de outra classe ao array privado acima.
    public var getListStory: [Stories] {
        story
    }
    
//    Variavel criada para buscar e guardar o numero de linhas que a collection vai ter
    public var numberOfItens: Int {
        2
    }
    
//    O método abaixo altera o tamanho das célucas de uma collectionView. Quando o indexPath.row passar na posicao 0, executará um tamanho e quando passar em outra posicao executará outro tamanho. No parametro do metodo deverá ser informado quem é esse indexPath e quem é esse frame(Qual Collection).
    public func sizeForItem(indexPath: IndexPath, frame: CGRect) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: 120, height: frame.height)
        } else {
            return CGSize(width: frame.width - 120, height: frame.height)
        }
    }
//    A funcao abaixo busca o objeto que foi criado para guardar os dados json que foram transfamados em swift na camada de servico. Para isso chamamos o método getHomeDataJson e na closure informamos que em caso de ausencia de erro o nosso posts e o nosso story dessa classe receberá o estiver em homeData.posts e em homeData.stories. É na constante homeData que estárão os nossos dados decodificados do json. Para esse método executar ele precisa ser chamado no viewDidLoad da controller. Quando a view carregar, o método que busca os dados na view model será executado e este por sua vez, executará o método que decodifica o json criado na camada de service.
    public func fetchAllRequest() {
        service.getHomeDataURLSession { homedata, error in
            if error == nil {
                self.posts = homedata?.posts ?? []
                self.story = homedata?.stories ?? []
                self.delegate?.success()
            } else {
                self.delegate?.error()
            }
        }
    }
}
