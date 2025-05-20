const inputImagem = document.getElementById('inputImagem');
const btnAdicionar = document.getElementById('btnAdicionar');
const galeria = document.getElementById('galeria');

// Carrega imagens do localStorage ao iniciar
window.onload = () => {
  const imagens = JSON.parse(localStorage.getItem('galeria')) || [];
  imagens.forEach(img => criarImagemNoDOM(img.id, img.src));
};

// Gera um ID único
function gerarID() {
  return '_' + Math.random().toString(36).substr(2, 9);
}

// Adiciona imagem ao clicar no botão
btnAdicionar.addEventListener('click', () => {
  const arquivo = inputImagem.files[0];
  if (!arquivo) return;

  const reader = new FileReader();
  reader.onload = () => {
    const id = gerarID();
    const src = reader.result;

    criarImagemNoDOM(id, src);
    salvarImagem(id, src);
  };
  reader.readAsDataURL(arquivo);
});

// Cria e adiciona <img> no DOM
function criarImagemNoDOM(id, src) {
  const img = document.createElement('img');
  img.src = src;
  img.dataset.id = id;
  img.title = 'Clique para remover';
  img.classList.add('imagem');

  img.addEventListener('click', () => {
    galeria.removeChild(img);
    removerImagem(id);
  });

  galeria.appendChild(img);
}

// Salva no localStorage
function salvarImagem(id, src) {
  const imagens = JSON.parse(localStorage.getItem('galeria')) || [];
  imagens.push({ id, src });
  localStorage.setItem('galeria', JSON.stringify(imagens));
}

// Remove do localStorage
function removerImagem(id) {
  let imagens = JSON.parse(localStorage.getItem('galeria')) || [];
  imagens = imagens.filter(img => img.id !== id);
  localStorage.setItem('galeria', JSON.stringify(imagens));
}
