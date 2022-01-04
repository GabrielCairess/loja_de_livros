class Midia
  attr_accessor :valor
  attr_reader :titulo

  def valor_com_desconto
    @valor - (@valor * @desconto)
  end

  def valor_formatado
    "R$ #{@valor}"
  end
end