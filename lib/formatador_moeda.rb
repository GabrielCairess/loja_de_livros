#encoding: utf-8

module FormatadorMoeda
  def formata_moeda(*variaveis_e_metodos)
    variaveis_e_metodos.each do |name|
      define_method("#{name}_formatado") do
        valor = respond_to?(name) ? send(name) : instance_variable_get("@#{name}")
        "R$ #{valor}"
      end
    end
  end
end