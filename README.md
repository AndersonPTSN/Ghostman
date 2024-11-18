# Ghostman

<div align="center">
  
![image](https://github.com/user-attachments/assets/c5571aed-a1cf-4f4a-aa48-ec330413a190)


Um jogo top-down com movimentação (← ↑ → ↓) na qual seu objetivo é pegar o Pac-man, mas cuidado, se ele pegar o doce é você que terá de fugir dele!

## Principais caracteristicas do jogo: 

**Visão global:** Ao apertar "Q" você pode visualizar o campo como um todo, e se estiver com a opção "Forma de colisões visíveis" você podera visualizar o campo de visão do Pac-man e a área de interação do Ghostman (que é 1/4 maior que a câmera)

![image](https://github.com/user-attachments/assets/5a11a5ae-c78c-4046-8fdf-98a83ca6275b)


**Árvore de comportamento:** Cada objeto do jogo (com exessão do jogador) possuem uma árvore de comportamento

![image](https://github.com/user-attachments/assets/eb1e8aa2-1bbc-4f34-818f-1370dd5b6fe1)

**Chunk loader:** Caso a caixa de interação do Ghostman entre em um chunk ele se torna ativo (estado esse mostrado pela diferença da cor do terreno) fazendo com que os inimígos só interajam caso a chunk esteja ativa, o mesmo vale para a geração de doces

![image](https://github.com/user-attachments/assets/35010c34-bbbc-475f-a416-070ecbfc4a64)


</div>
