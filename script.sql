#criação banco de dados
create database ecommerce;
use ecommerce;

#criar tabela cliente
CREATE TABLE client (
    idClient INT AUTO_INCREMENT PRIMARY KEY,
    Fname VARCHAR(50),
    Minit CHAR(3),
    Lname VARCHAR(50),
    CPF CHAR(11),
    CNPJ CHAR(14),
    Address VARCHAR(100),
    clientType ENUM('PF', 'PJ') NOT NULL,
    CONSTRAINT unique_cpf UNIQUE(CPF),
    CONSTRAINT unique_cnpj UNIQUE(CNPJ),
    CHECK (
        (clientType = 'PF' AND CPF IS NOT NULL AND CNPJ IS NULL) OR
        (clientType = 'PJ' AND CNPJ IS NOT NULL AND CPF IS NULL)
    )
);

-- criar tabela produto
-- size = dimensao do produto
create table product(
idProduct int auto_increment primary key,
Pname varchar(10) not null,
classification_kids bool default false,
category enum('Eletrônico', 'Vestimenta','Brinquedos','Alimentos','Móveis'),
avaliação float default 0,
size varchar(10),
constraint unique_cpf_client unique (CPF)
);

CREATE TABLE payments (
    idPayment INT AUTO_INCREMENT PRIMARY KEY,
    idClient INT,
    typePayment ENUM('Boleto','Cartão','Dois Cartões'),
    limitAvailable FLOAT,
    FOREIGN KEY (idClient) REFERENCES client(idClient)
);

-- criar tabela pedido
create table orders(
idOrder int auto_increment primary key,
idOrderClient int,
orderStatus enum('Cancelado','Confirmado','Em processamento') default 'Em processamento',
orderDescription varchar(255),
sendValue float default 10,
paymentCash bool default false,
constraint fk_orders_client foreign key (idOrderClient) references clients(idClient)

);

create table productStorage(
idProdStorage int auto_increment primary key,
storageLocation varchar(255),
quantity int default 0
);

create table storageLocation(
idLproduct int,
idLstorage int,
location varchar(255) not null,
primary key (idLproduct, idLstorage ),
constraint fk_storage_location_product foreign key (idLproduct) references product (idProduct),
constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
);

#criar tabela fornecedor
create table supplier(
idSupplier int auto_increment primary key,
SocailName varchar(255) not null,
CNPJ char(15) not null,
contact char(11) not null,
constraint unique_supplier unique (CNPJ)
);

#criar tabela vendedor
create table seller(
idSeller int auto_increment primary key,
SocialName varchar(255) not null,
AbstName varchar(255) not null,
CNPJ char(15),
CPF char(9),
location varchar(255),
contact char(11) not null,
constraint unique_cnpj_seller unique (CNPJ),
constraint unique_cpf_seller unique (CPF)
);

create table productSeller(
idPseller int,
idProduct int,
prodQuantity int default 1,
primary key (idPseller, idProduct),
constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
constraint fk_product_product foreign key (idProduct) references product(idProduct)
);

CREATE TABLE delivery (
    idDelivery INT AUTO_INCREMENT PRIMARY KEY,
    idOrder INT,
    statusDelivery ENUM('Postado', 'Em trânsito', 'Entregue', 'Cancelado'),
    trackingCode VARCHAR(50),
    FOREIGN KEY (idOrder) REFERENCES orders(idOrder)
);

show tables;

show databases;

use information_schema;
show tables;

desc referential_constraints;
select * from referential_constraints;


insert into Client (Fname, Minit, Lname, CPF, Address)
values('Maria', 'M', 'Silva', 12346789, 'rua silva de prata 29, Carangola - Cidade das flores'),
('Matheus', '0', 'Pimentel', 987654321, 'rua alamemeda 289 - Centro Cidade das flores'), 
('Ricardo', 'F', 'Silva', 45678913, 'avenida alemeda vinha 1009, Centro Cidade das flores'), 
('Julia', 'S', 'França', 789123456,'rua lareijras 861, Centro - Cidade das flores'), 
('Roberta', 'G', 'Assis', 98745631, 'avenidade koller 19, Centro Cidade das flores'), 
('Isabela', 'M', 'Cruz', 654789123, 'rua alemeda das flores 28, Centro Cidade das flores');

insert into orders(idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) values
(1,null,'compra via aplicativo',null,1),
(2,null,'compra via aplicativo',50,1),
(3,'Confirmado',null,null,1),
(4,null,'compra via web site',150,1);

select * from orders;
insert into Clients (idPOproduct, idPOorder, poQuantity, poStatus) values
(1,1,2,null),
(2,1,1,null),
(3,2,1,null);


insert into product (Pname, classification_kids, category, avaliação, size) values
('Fone de ouvido', false, 'Eletrônico', '4', null),
('Barbie Elsa', true, 'Brinquedos', '3', null),
('Body Carters', true, 'Vestimenta', '5', null),
('Microfone Vedo Youtuber', False, 'Eletrônico', '4', null),
('Sofá retrátil', False, 'Móveis', '3', '3x57x80'),
('Farinha de arroz', False, 'Alimentos', '2', null),
('Fire Stick Amazon', False, 'Eletrônico', '3', null);

select * from clients;
select * from product;

insert into productStorage(storageLocation, quantity) values
('Rio de Janeiro',1000),
('Rio de Janeiro',500),
('São Paulo',10),
('São Paulo',100),
('São Paulo',10),
('Brasilia',60);



insert into storageLocation (idLproduct, idLstorage, location) values
(1,2,'RJ'),
(2,6,'GO');

insert into supplier (SocialName, CNPJ, contact) values
('Almeida e filhos',14183253000152,2835269757),
('Eletronicos Silva',45353724000157,1730254328),
('Eletronicos CIA',56541821000190,9631354521);

select * from supplier;

insert into productSupplier (idPsSupplier, idPsProduct, quantity) values
(1,1,500),
(1,2,400);


select * from seller;

select count(*) from clients;

select * from clients c, orders o where c.idClient = idOrderClient;

select Fname, Lname, idOrder, orderStatus 
from clients c, orders o
where c.idClient = idOrderClient;

select concat(Fname, ' ', Lname) as Client, idOrder as Request, orderStatus as Status
from clients c, orders o
where c.idClient = idOrderClient;

insert into orders (idOrdersClient, orderStatus, orderDescription, senValue, paymentCash) values
(2,default,'compra via aplicativo',null,1);

select count(*) from clients c, orders o
where c.idClient = idOrderClient;

select * from productOrder;
select * from clients c inner join orders o ON c.idClient = o.idOrderClient
inner join productOrder p on p.idPOorder = io.dOrder
group by idClient;

#SELECT simples com filtro (clientes PF)
SELECT Fname, Lname, Address
FROM client
WHERE clientType = 'PF';

#Expressão para atributo derivado (nome completo)
SELECT CONCAT(Fname, ' ', Minit, ' ', Lname) AS fullName, Address
FROM client;

# Ordenação por avaliação de produto (desc)
SELECT Pname, avaliação
FROM product
ORDER BY avaliação DESC;

#Contagem de pedidos por cliente
SELECT c.idClient, CONCAT(c.Fname, ' ', c.Lname) AS cliente, COUNT(o.idOrder) AS total_pedidos
FROM client c
LEFT JOIN orders o ON c.idClient = o.idOrderClient
GROUP BY c.idClient
ORDER BY total_pedidos DESC;

#Condições com HAVING (clientes com mais de 1 pedido)
SELECT c.idClient, CONCAT(c.Fname, ' ', c.Lname) AS cliente, COUNT(o.idOrder) AS total_pedidos
FROM client c
JOIN orders o ON c.idClient = o.idOrderClient
GROUP BY c.idClient
HAVING COUNT(o.idOrder) > 1;

#Algum vendedor também é fornecedor?
SELECT s.SocialName AS nome, s.CNPJ
FROM seller s
JOIN supplier f ON s.CNPJ = f.CNPJ;

#Relação de produtos, fornecedores e estoques
SELECT p.Pname, f.SocailName, ps.prodQuantity
FROM product p
JOIN productSeller ps ON p.idProduct = ps.idProduct
JOIN seller s ON ps.idPseller = s.idSeller
JOIN supplier f ON f.CNPJ = s.CNPJ;

#Nomes dos fornecedores e seus produtos
SELECT DISTINCT f.SocailName, p.Pname
FROM supplier f
JOIN seller s ON f.CNPJ = s.CNPJ
JOIN productSeller ps ON ps.idPseller = s.idSeller
JOIN product p ON p.idProduct = ps.idProduct;
