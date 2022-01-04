#encoding: utf-8

class Livro < Midia
  attr_reader :categoria, :autor
  include FormatadorMoeda
  
  def initialize(titulo, autor, isbn = "1", numero_de_paginas, valor, categoria)
    @titulo = titulo
    @autor = autor
    @isbn = isbn
    @numero_de_paginas = numero_de_paginas
    @categoria = categoria
    @valor = valor
    @desconto = 0.15
  end
  
  def to_s
    "Autor: #{@autor}, Titulo: #{@titulo}, Isbn: #{@isbn}, Páginas: #{@numero_de_paginas}, Categoria: #{@categoria}"
  end

  def eql?(outro_livro)
    @isbn == outro_livro.isbnCasa
  end

  def hash
    @isbn.hash
  end
end