//
//  ViewController.swift
//  PrimeiroAppMVVM
//
//  Created by Igor Fortti on 15/02/23.
//

import UIKit


class HomeVC: UIViewController {
    
//    Variavel que guarda a Screen. Na Screen estao os elementos visuais.
    private var homeScreen: HomeScreen?
    
//    Variavel que guarda a viewModel. É na camada view model que fica a responsabilidade de conter toda a parte logica da aplicacao.
    private var viewModel: HomeViewModel = HomeViewModel()
    
//    Método que quando dispara instacia a HomeScreen() na variavel homeScreen e atribui na view essa variavel que instanciou a home Screen. Através dele dizemos que a nossa view está recebendo a screen criada para ela em outro arquivo.
    override func loadView() {
        homeScreen = HomeScreen()
        view = homeScreen
    }
    
// Método view Did Load, onde é chamado os métodos que precisam ser disparados quando essa view for chamada. Está sendo assinado os protocolos delegate e datasource da collection que está na screen. É a controller e nao a screen que assina e implementa os métodos do protocolo da Collection e da table.
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate(delegate: self)
        viewModel.fetchAllRequest()
    }

}

extension HomeVC: HomeViewModelProtocol {
    func success() {
        print(#function)
//        O dispatchQueue.main.async é usado quando queremos executar algo somente quando estivermos na nossa thread principal. É obrigatório o seu uso quando se trabalha com URLSession. Porém, com o Alamofire, não é obrigatório, sendo indicado para os casos em que realmente tivermos um problema de thread (linha roxa).
        DispatchQueue.main.async {
//            É a partir da assinatura do protocolo da collection que ela é iniciada. Colocando a assinatura do delegate aqui, toda vez que executarmos o método success a collectionView será iniciada. Dessa forma, através do protocolo da view model, esse método success está sendo disparado dentro do FetchAllRequest, ou seja, a collection view será iniciada somente após os dados já terem sido requisitados e somente se essa requisicao deles for realizada sem erros.
            self.homeScreen?.configProtocolsCollectionView(delegate: self, dataSource: self)
        }
    }
    
    func error() {
        print(#function)
        
    }
    
    
}


// Extension para implementacao dos protocolos da collectionView. Implementar os protocolos e controlar acoes de botoes e text field é reponsabilidade da controller. 
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItens
    }
    
//    O método abaixo está dizendo qual vai ser a célula que será apresentado na collectionView. Nesse caso estamos dizendo qual é a celula através do identifier e fazendo uma quege para que essa célula seja do tipo da classe em que criamos a célula. Assim, é possivel ter acesso ao método de setup criado lá na célula, para enviarmos para a célula os daodos que ela precisará para exibir o conteúdo nela. O método setup cell, pede que informemos um array do tipo Storiers, que é o tipo do objeto a ser apresentado. O método executará e e no seu corpo ele envia esse mesmo array para a viewModel da Collection e então ela terá as informacoes para passar ao cellforrow da collection que está dentro dela.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        PARA USAR DUAS CELULAS REGISTAR AS DUAS CELULAS COM O IDENTIFIER NA SCREEN
        if indexPath.row == 0 {
            let cell = homeScreen?.collectionView.dequeueReusableCell(withReuseIdentifier: StoryCardCollectionViewCell.identifier, for: indexPath) as? StoryCardCollectionViewCell
            cell?.setupCell(listStory: viewModel.getListStory)
            return cell ?? UICollectionViewCell()
        } else {
            let cell = homeScreen?.collectionView.dequeueReusableCell(withReuseIdentifier: PostCardCollectionViewCell.identifier, for: indexPath) as? PostCardCollectionViewCell
            cell?.setupCell(listPosts: viewModel.getListPosts)
            return cell ?? UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        viewModel.sizeForItem(indexPath: indexPath, frame: collectionView.frame)
    }
}
