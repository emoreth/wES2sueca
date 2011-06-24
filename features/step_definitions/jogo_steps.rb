LADO = {
  "baixo" => "bottom",
  "esquerda" => "left",
  "cima" => "top",
  "direita" => "right"
}

VIRADA_PARA_BAIXO = {
  "baixo" => "b1fv.png",
  "cima" => "b1fv.png",
  "esquerda" => "b1fh.png",
  "direita" => "b1fh.png"
}

Então /^eu devo ver as cartas (?:de|da) ((?:baixo|esquerda|cima|direita)) viradas para ((?:cima|baixo))$/ do |lado, virada|
  all(".card #{LADO[lado]}").each do |carta|
    if virada == "baixo"
      carta["src"].should =~ VIRADA_PARA_BAIXO[lado]
    else
      carta["src"].should_not =~ VIRADA_PARA_BAIXO[lado]
    end
  end
end