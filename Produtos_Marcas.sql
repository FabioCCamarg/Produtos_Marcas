	create table marcas (
	mrc_id int primary key auto_increment,
	mrc_nome varchar (50) not null,
	mrc_nacionalidade varchar(50)
	);

	create table produtos (
	prd_id int primary key auto_increment,
	prd_nome varchar (50) not null,
	prd_qt_estoque int not null default 0,
	prd_estoque_mim int not null default 0,
	prd_data_frabricacao timestamp default now(),
	prd_perecivel boolean,
	prd_valor decimal (10,2),

	prd_marca_id int,
	constraint fk_marcas foreign key (prd_marca_id) references marcas(mrc_id)
	);

	create table fornecedores (
	frn_id int primary key auto_increment,
	frn_nome varchar(50),
	frn_email varchar (50)
	);

	create table produto_fornecedor(
	pf_prod_id int references produtos (prd_id),
	pf_forn_id int references fornecedores (frn_id),	 

	primary key (pf_prod_id, pf_forn_id)
	);

/*Inserindo registros TABELA PRODUTOS:*/

	insert into produtos (prd_nome, prd_qt_estoque, prd_estoque_mim, prd_perecivel, prd_valor, prd_marca_id)
	values ('Celular', 90, 12, 0, 3500, 1);
	insert into produtos (prd_nome, prd_qt_estoque, prd_estoque_mim, prd_perecivel, prd_valor, prd_marca_id)
	values ('TV', 120, 19, 0, 5599, 2);
	insert into produtos (prd_nome, prd_qt_estoque, prd_estoque_mim, prd_perecivel, prd_valor, prd_marca_id)
	values ('Fritadeira', 10, 1, 0, 500, 3);
	insert into produtos (prd_nome, prd_qt_estoque, prd_estoque_mim, prd_perecivel, prd_valor, prd_marca_id)
	values ('Tenis', 205, 11, 0, 200, 4);
	insert into produtos (prd_nome, prd_qt_estoque, prd_estoque_mim, prd_perecivel, prd_valor, prd_marca_id)
	values ('Notebook', 5, 1, 0, 6500, 5);
	insert into produtos (prd_nome, prd_qt_estoque, prd_estoque_mim, prd_perecivel, prd_valor, prd_marca_id)
	values ('Arroz', 40, 20, 1, 15, 6);

/*Inserindo registros TABELA MARCAS:*/

	insert into marcas(mrc_nome, mrc_nacionalidade)
	values ('Apple', 'Americana');
	insert into marcas(mrc_nome, mrc_nacionalidade)
	values ('Samsung', 'Coreana');
	insert into marcas(mrc_nome, mrc_nacionalidade)
	values ('Mondial', 'Brasileira');
	insert into marcas(mrc_nome, mrc_nacionalidade)
	values ('Nike', 'Americana');
	insert into marcas(mrc_nome, mrc_nacionalidade)
	values ('Dell', 'Americana');
	insert into marcas(mrc_nome, mrc_nacionalidade)
	values ('Tio Joao', 'Brasileira');
/*Inserindo registros TABELA FORNECEDORES*/ 

	insert into fornecedores (frn_nome, frn_email)
	values ('Felipe', 'felipe@gmail.com');
	insert into fornecedores (frn_nome, frn_email)
	values ('Alessandra', 'Alessandra@gmail.com');
	insert into fornecedores (frn_nome, frn_email)
	values ('Gustavo', 'Gustavo@gmail.com');
	insert into fornecedores (frn_nome, frn_email)
	values ('Angelina', 'Angelina@gmail.com');

/*Crie uma view que mostra todos os produtos e suas respectivas marcas;*/

	create view TodosProdutos_Marcas as
	select p.prd_nome , m.mrc_nome
    	from produtos p
    	inner join marcas m 
    	on p.prd_marca_id = m.mrc_id;
    
    	select * from TodosProdutos_Marcas;

/*Crie uma view que mostra todos os produtos e seus respectivos fornecedores;*/

	create view TodosProdutos_Fornecedores as
	select p.prd_nome as "Nome_Produto", f.frn_nome as "Nome_Fornecedor"
	from produtos p
	inner join fornecedores f
	on f.frn_id = p.prd_id;

	select * from TodosProdutos_Fornecedores;

/*Crie uma view que mostra todos os produtos e seus respectivos fornecedores e marcas;*/

	create view TodosProdutos_Fornecedores_Marcas as
  	select p.prd_nome "Nome_Produto", f.frn_nome as "Nome_Fornecedor", m.mrc_nome as "Marca"
	from produtos p
	inner join fornecedores f
	on f.frn_id = p.prd_id
    	inner join marcas m
    	on m.mrc_id = p.prd_marca_id;
    
    
	select * from TodosProdutos_Fornecedores_Marcas;

/*Crie uma view que mostra todos os produtos com estoque abaixo do mínimo;*/

	create view produtos_abaixo_estoque_minimo as
	select p.prd_nome as "Nome_Produto" 
	from produtos p
	where p.prd_qt_estoque < p.prd_estoque_mim;

	select * from produtos_abaixo_estoque_minimo;
/*Adicione o campo data de validade. Insira novos produtos com essa informação;*/

	alter table produtos
	add prd_data_validade date;


	insert into produtos (prd_nome, prd_qt_estoque, prd_estoque_mim, prd_data_frabricacao, prd_perecivel, prd_valor, prd_marca_id, prd_data_validade)
	values ('Danone', 20, 12, '2023-09-02', 1, 5.50, 1, '202-10-29');
	insert into produtos (prd_nome, prd_qt_estoque, prd_estoque_mim, prd_data_frabricacao, prd_perecivel, prd_valor, prd_marca_id, prd_data_validade)
	values ('Yakut', 200, 1, '2023-09-15', 1, 6.99, 2, '2024-10-15');

/*Selecionar os produtos com preço acima da média.*/

	select prd_id, prd_nome, prd_valor
	from produtos
	where prd_valor > (select avg(prd_valor) from produtos
    	
);


