drop table if exists links;
drop table if exists publications;
drop table if exists bills;
drop table if exists sessions;
drop table if exists parliamentary_houses;
drop table if exists bill_types;
drop table if exists bill_categories;
drop table if exists publication_types;
drop table if exists content_types;

create table content_types (
	id serial not null,
	content_type varchar(255) not null,
	primary key (id)
);

create table publication_types (
	id serial not null,
	label varchar(255) not null,
	bill_system_id int not null,
	description text,
	primary key (id)
);

create table bill_categories (
	id serial not null,
	label varchar(255) not null,
	primary key (id)
);

create table bill_types (
	id serial not null,
	label varchar(255) not null,
	bill_system_id int not null,
	description text not null,
	bill_category_id int not null,
	primary key (id),
	constraint fk_bill_category foreign key (bill_category_id) references bill_categories(id)
);

create table sessions (
	id serial not null,
	bill_system_id int not null,
	primary key (id)
);

create table parliamentary_houses (
	id serial not null,
	short_label varchar(255) not null,
	label varchar(255) not null,
	primary key (id)
);

create table bills (
	id serial not null,
	short_title varchar(255) not null,
	bill_system_id int not null,
	is_act boolean default false,
	is_withdrawn boolean default false,
	is_defeated boolean default false,
	originating_house_id int,
	current_house_id int,
	originating_session_id int not null,
	bill_type_id int not null,
	updated timestamp not null,
	constraint fk_originating_session foreign key (originating_session_id) references sessions(id),
	constraint fk_originating_house foreign key (originating_house_id) references parliamentary_houses(id),
	constraint fk_current_house foreign key (current_house_id) references parliamentary_houses(id),
	constraint fk_bill_type foreign key (current_house_id) references parliamentary_houses(id),
	primary key (id)
);

insert into parliamentary_houses (short_label, label) values( 'Commons', 'House of Commons' );
insert into parliamentary_houses (short_label, label) values( 'Lords', 'House of Lords' );
	
create table publications (
	id serial not null,
	title varchar(1000) not null,
	display_date date not null,
	bill_system_id int not null,
	parliamentary_house_id int,
	publication_type_id int not null,
	bill_id int not null,
	constraint fk_house foreign key (parliamentary_house_id) references parliamentary_houses(id),
	constraint fk_publication_type foreign key (publication_type_id) references publication_types(id),
	constraint fk_bill foreign key (bill_id) references bills(id),
	primary key (id)
);

create table links (
	id serial not null,
	title varchar(1000) not null,
	url varchar(1000) not null,
	bill_system_id int not null,
	publication_id int not null,
	content_type_id int not null,
	constraint fk_publication foreign key (publication_id) references publications(id),
	constraint fk_content_type foreign key (content_type_id) references content_types(id),
	primary key (id)
);

