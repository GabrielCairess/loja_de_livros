# coding: utf-8

class Dvd < Midia
  attr_reader :titulo

  extend FormatadorMoeda

  formata_moeda :valor_com_desconto, :valor

  def initialize(titulo, valor, categoria)
    super()
    @titulo = titulo
    @valor = valor
    @categoria = categoria
  end

  def to_s
    %Q{Título: #{@titulo}, Valor: #{@valor}}
  end
end