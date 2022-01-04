class Set
attr_reader :livros
  include Enumerable

  def initialize
    @livros = []
    @banco_de_arquivos = BancoDeArquivos.new
  end
  
  def adiciona(livro)
    salva livro do 
      @livros << livro
    end
  end
  
  def livros
    @livros ||= @banco_de_arquivos.carrega
  end

  def livros_por_categoria(categoria)
    @livros.select { |livro| livro.categoria == categoria }
  end

  def each
    livros.each { |livro| yield livro }
  end

  private 

  def salva(livro)
    @banco_de_arquivos.salva(livro)
    yield
  end
end