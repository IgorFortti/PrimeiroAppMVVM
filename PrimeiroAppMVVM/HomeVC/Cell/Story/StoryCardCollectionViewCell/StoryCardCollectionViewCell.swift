//
//  CustomCollectionViewCellVC.swift
//  PrimeiroAppMVVM
//
//  Created by Igor Fortti on 16/02/23.
//

import UIKit

// Essa classe é a responsável pelo que será apresentado na collectionView que criamos.
class StoryCardCollectionViewCell: UICollectionViewCell {
    
//    Variavel identificadora da Celula. O identificador é informado na view, tanto no método cell for item da controller e na própria criacao da collection no register na screen.
    static let identifier: String = "StoryCardCollectionViewCell"
    
// Variavel que instancia a screen da célula. Dessa forma, todos os elementos e constraints adicionados da screen da célula ficam guardados nessa variável. Essa Screen contém uma view, usada para dar cor e diferenciar a collection do restante tela e uma outra collection, com scroll vertical, que por sua vez exibirão na tela os nossos dados.
    private var screen: StoryCardCollectionViewCellScreen = StoryCardCollectionViewCellScreen()
    
//    Variavel do tipo opcional criada para guardar a camada de lógica da célula. Nesse caso ela será usada para guardar o array com os dados que o método setupCell vai obter quando chamado na HomeVC. Através do init da classe disparado dentro do método setup cell, é informado que a variavel listStories dentro da classe receberá o array da homeViewModel informado dentro do parametro setup cell, quando chamada na classe HomeVC.
    private var viewModel: StoryCardViewModel?

// No init da view ficam os métodos que precisam ser disparados para ela for chamada. Aqui ela assina o método que configura a screen criada para montagem dos seus elementos e assina os protocolos da collectionView com scroll vertical criada aqui para ser quem vai exibir os dados na tela.
    override init(frame: CGRect) {
        super.init(frame: frame)
        configScreen()
        screen.configProtocolsCollectionView(delegate: self, dataSource: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    Dentro desse método foi configurada a view da celula. A content view, adicionou a screen atráves da variavel screen que guarda a screen. A screen é uma view dentro da célula, portanto seu translate precisa ser falso e suas constraints configuradas. Todas foram colocadas nos limites da contentview, que é a célula.
    private func configScreen() {
        screen.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(screen)
        screen.pin(to: contentView)
    }
    
// Esse método é o que instacia a viewModel da célula quando ele é chamado. Isto porque o que for passado em seu parametro, automaticamente será o mesmo valor do init da célula, que por sua vez é o que alimenta a variavel array dentro da viewModel da Celula. Com isso é possível fazermos a viewModel da célula ter o mesmo array que está na viewModel da Home.
    public func setupCell(listStory: [Stories]) {
        viewModel = StoryCardViewModel(listStory: listStory)
    }
}
// Extension para configurar o número de itens da collection Vertical, a célula que será apresentada e executará o método criado na célula que apresentará os conteúdos nessa célula. Também é chamado na extension o método que configura a altura do item.
extension StoryCardCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        O numero de itens da collection vertical é o número de itens do array presente na nossa view model. Esta como opcional, pois está classe é criada com a propriedade que armazena o array vazia. Somente quando a classe é instaciada que é informado o valor que esse array armazenará. Nesse caso, ela foi instanciada dentro do método setupCell, que foi executado na HomeVC. Dessa forma, a view model abaixo passou a armazenar o mesmo array que a view model da Home. Em caso da classe view model nao ser instanciada, o numero de itens da collection será 0.
        return viewModel?.numberOfItems ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        o guard let foi feito, pois como está no comentário acima, viewModel é opcional, podendo ou não ter valor. Em caso de não ter valor, ele retorna UICollectionViewCell vazia. Em caso de ter valor ele guarda o valor instanciado para a viewModel e tira a opcionalidade dela. É como se ele fizesse uma conferencia para ver o estado atual que ela está, vazia ou com valor.
        guard let viewModel = viewModel else { return UICollectionViewCell() }
        
        let cell = screen.collectionView.dequeueReusableCell(withReuseIdentifier: StoryCollectionViewCell.identifier, for: indexPath) as? StoryCollectionViewCell
//        Aqui detro desse setupCell, método criado dentro da célula da collectionVertical, que conterá os dados sendo apresentados, estamos passando um único elemento do array, através do indexpath.row. o indexpath.row, executa uma vez para cada elemento dentro do array, pegando suas características e montando uma célula para cada elemento do array, mantendo suas características e alterando aquilo que o método setupCell pede para alterar. Ou seja, no parametro, setupCell pede no campo data um unico objeto do tipo Stories. Isso porque no corpo de setupCell, alteraremos a imagem, o texto da label e o isHidden de um botao. Em nosso viewModel, temos um array com varios objetos do tipo Storiers. Portanto, em nosso viewModel, criamos o método loudCurrent, que através do indexpath.row acessa o array e trás cada objeto conforme o número de itens do numberOfItens. O método loundCurrent poderia nao existir caso nossa classe tivesse acesso ou array em viewModel, mas ele é do tipo private. Por isso a viewmodel disponibilizou esse método para conseguirmos pegar o indexpath.row de cada elemento do array que está nela. SetupCell recebendo o indexpath.row, ou seja cada elemento separado um de cada vez, armazenará essa informacao com o seu parametro e passará esse valor para as propriedades da célula da collection vertical que precisa desses valores para saber o que por na tela.
        cell?.setupCell(data: viewModel.loudCurrentStory(indexPath: indexPath), indexPath: indexPath)
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 120)
    }
    
}
