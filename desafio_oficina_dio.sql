Ir para o conteúdo
Thiago-Eulácio
/
Cria-o-Banco-de-Dados-Ecommerce

Digite /para pesquisar

Código
Problemas
Solicitações pull
Ações
Projetos
Segurança
Percepções
Largura do painel
Use um valor entre 17 % e 38 %

21
Alterar largura
arquivos
Ir para o arquivo
t
Criação_BD_Ecommerce.sql
Desafio_Final.sql
Inserções_Ecommerce.sql
Projeto_BD_Oficina.sql
Consultas_Ecommerce.sql
README.md
desafio_indice.sql
desafio_views.sql
Documentação  •  Compartilhar feedback
Migalhas de pãoCria-o-Banco-de-Dados-Ecommerce
/Projeto_BD_Oficina.sql
Último commit
Thiago-Eulácio
Thiago-Eulácio
Adicionar arquivos via upload
338a62c
 · 
há 4 meses
História
Migalhas de pãoCria-o-Banco-de-Dados-Ecommerce
/Projeto_BD_Oficina.sql
Metadados e controles de arquivo

Código

Culpa
149 linhas (117 locais) · 4,08 KB
-- Criando o Schema lógico--
Create schema oficina;

-- Entrando no Banco de dados oficina--
use oficina

-- Criando a tabela Clientes
create table clientes (
	idClientes int,
	nome varchar (45) not null,
	cpf char (11) not null unique,
	endereco varchar (45) not null,
	telefone varchar (12) not null unique,
    constraint pk_idclientes primary key (idClientes)
);

-- Criando a tabela mecânicos --
create table mecanicos (
	idMecanicos int,
	nome varchar (45) not null,
	especialidade varchar (15) not null,
	endereco varchar (45) not null,
	constraint pk_idMecanicos primary key (idMecanicos)
);

-- Criando a tabela Automóveis--
create table veiculo (
	codVeiculo int,
	nomeVeiculo varchar (45) not null,
	marca varchar (45) not null,
	modelo varchar (45) not null,
	placa varchar (8) not null unique,
	idClientes int,
	idMecanicos int,
	constraint pk_cod_veiculo primary key (codVeiculo),
	constraint fk_idclientes foreign key (idClientes) references clientes(idClientes),
	constraint fk_idMecanicos foreign key (idMecanicos) references mecanicos(idMecanicos)
);

-- Criando a tabela ordem de serviço --
create table ordemServico (
	numero int,
	status enum ('Em Conserto','Finalizado') default ('Em Conserto'),
	dataEntrega date,
	dataEmissao date,
	valor float,
	os_idClientes int,
	constraint pk_os primary key (numero),
	constraint fk_os_clientes foreign key (os_idClientes) references clientes(idClientes)
);


-- Criando tabela Mecanicos_Ordem_de_Serviço --
create table mecanicos_os (
	codigo_os int,
	idMecanicos int,
	os_numero int,
	constraint pk_mecanicos_os primary key(codigo_os),
	constraint fk_mecanicos_os foreign key (idMecanicos) references mecanicos(idMecanicos),
	constraint fk_os foreign key (os_numero) references OrdemServico(numero)	
);

-- Criando tabela mão de obra (servico) --
create table servico (
	codigo int,
	descricao varchar(50),
	quantidade int,
	valor float,
	constraint pk_servico primary key (codigo)
);

-- Criando a tabela servico_ordem_de_servico --
-- Obs tabela apenas para vincular a OS com o serviço por isso não foi necessário determinar uma primary Key somente FK
create table os_servico (
	num_os int,
	num_servico int,
	constraint fk_servico foreign key (num_servico) references servico(codigo),
	constraint fk_os_servico foreign key (num_os) references ordemServico(numero)
);

-- Criando a tabela peças --
create table pecas (
	codpecas int,
	descricao varchar (45),
	valor float,
	quantidade int,
	constraint pk_pecas primary key (codpecas)
)

-- Criando a tabela os_peças --
-- Obs tabela apenas para vincular a OS com as peças por isso não foi necessário determinar uma primary Key somente FK
create table os_pecas (
	os_numero int,
	codpecas int,
	constraint fk_os_pecas foreign key (os_numero) references ordemServico(numero),
	constraint fk_pecas foreign key (codpecas) references pecas(codpecas)
)

-- criando scripts de recuperação --

-- Recuperações simples com SELECT Statement --
-- recuperando clientes --
Select * from clientes;

-- recuperando veiculos --
Select * from veiculo;

-- recuperando peças --
Select * from pecas;



-- Filtros com WHERE Statement --
-- Verificando qual o mecanico com um Id especifico --
select * from mecanicos where idMecanicos ='25'


-- Crie expressões para gerar atributos derivados --
select numero, dataEntrega, valor as total
from ordemServico 
where status='Finalizado'
order by numero, dataEntrega, valor limit 3;

-- Defina ordenações dos dados com ORDER BY --

select * from veiculo order by nome;

select * from clientes order by nome desc;

-- Condições de filtros aos grupos – HAVING Statement --

select count(*) as Qtd_Veiculos, nomeVeiculo
from veiculo 
group by nomeVeiculo 
having count(*) >= 1;


-- Crie junções entre tabelas para fornecer uma perspectiva mais complexa dos dados --

select c.nome, c.endereco, m.nome, m.especialidade, v.nomeVeiculo 
from veiculo v
inner join clientes c 
on c.idClientes=v.idClientes
inner join mecanicos m 
on v.idMecanicos=m.idMecanicos;




Cria-o-Banco-de-Dados-Ecommerce/Projeto_BD_Oficina.sql at main · Thiago-Eulalio/Cria-o-Banco-de-Dados-Ecommerce While the code is focused, press Alt+F1 for a menu of operations.