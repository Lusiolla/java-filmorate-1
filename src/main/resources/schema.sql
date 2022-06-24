-- удаление всех таблиц в БД
DROP TABLE IF EXISTS likes;
DROP TABLE IF EXISTS friends;
DROP TABLE IF EXISTS genre_film;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS genres_films;
DROP TABLE IF EXISTS films_genres;
DROP TABLE IF EXISTS genres;
DROP TABLE IF EXISTS films CASCADE;
DROP TABLE IF EXISTS mpaa CASCADE;
DROP TABLE IF EXISTS FRIENDS CASCADE;


-- создание таблиц
create table IF NOT EXISTS mpaa
(
    mpaa_id BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name    VARCHAR
);


create table IF NOT EXISTS films
(
    film_id      BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name         VARCHAR(255),
    description  VARCHAR(255),
    release_date Date,
    duration     VARCHAR(10),
    mpaa_id      int,
        CONSTRAINT fk_mpaa FOREIGN KEY (MPAA_id) REFERENCES MPAA(MPAA_ID) ON DELETE CASCADE ON UPDATE CASCADE
);



create table IF NOT EXISTS users
(
    user_id  BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    email    VARCHAR(30) NOT NULL,
    login    VARCHAR(30) NOT NULL,
    name     VARCHAR(30),
    birthday DATE
);

create table IF NOT EXISTS likes
(
    user_id BIGINT,
    film_id BIGINT,
    CONSTRAINT LIKES_PK PRIMARY KEY (user_id, film_id),
    CONSTRAINT fk_films FOREIGN KEY (film_id) REFERENCES films (film_id),
    CONSTRAINT fk_users FOREIGN KEY (user_id) REFERENCES users (user_id)

);

create table IF NOT EXISTS genres
(
    genre_id BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL PRIMARY KEY,
    name     VARCHAR(50)                             NOT NULL
);

CREATE TABLE IF NOT EXISTS films_genres
(
    film_id  BIGINT NOT NULL,
    genre_id BIGINT NOT NULL,
    CONSTRAINT FILMS_GENRES_PK PRIMARY KEY (film_id, genre_id),
    CONSTRAINT FILMS_GENRES_FK_1 FOREIGN KEY (film_id) REFERENCES films (film_id),
    CONSTRAINT FILMS_GENRES_FK_2 FOREIGN KEY (genre_id) REFERENCES genres (genre_id)
);

create table IF NOT EXISTS friends
(
    friend_id BIGINT NOT NULL,
    user_id   BIGINT NOT NULL,
    CONSTRAINT pk_friends PRIMARY KEY (user_id, friend_id),
    CONSTRAINT fk_friends1 FOREIGN KEY (user_id) REFERENCES users (user_id),
    CONSTRAINT fk_friends2 FOREIGN KEY (friend_id) REFERENCES users (user_id)
);


