-- удаление всех таблиц в БД
DROP TABLE IF EXISTS likes;
DROP TABLE IF EXISTS feeds;
DROP TABLE IF EXISTS friends;
DROP TABLE IF EXISTS films_genres;
DROP TABLE IF EXISTS genres;
DROP TABLE IF EXISTS mpaa CASCADE;
DROP TABLE IF EXISTS mpaa CASCADE;
DROP TABLE IF EXISTS director_films;
DROP TABLE IF EXISTS directors;
DROP TABLE IF EXISTS films CASCADE;
DROP TABLE IF EXISTS review_likes;
DROP TABLE IF EXISTS film_reviews;
DROP TABLE IF EXISTS users;

-- создание таблиц
CREATE TABLE IF NOT EXISTS mpaa
(
    mpaa_id BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name    VARCHAR
);

CREATE TABLE IF NOT EXISTS directors
(
    director_id BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name        VARCHAR(256) NOT NULL
);

CREATE TABLE IF NOT EXISTS films
(
    film_id      BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name         VARCHAR(255),
    description  VARCHAR(255),
    release_date DATE,
    duration     VARCHAR(10),
    mpaa_id      INT,
    CONSTRAINT fk_mpaa FOREIGN KEY (mpaa_id) REFERENCES mpaa (mpaa_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS director_films
(
    director_id BIGINT NOT NULL,
    film_id     BIGINT NOT NULL,
    CONSTRAINT fk_director_films1 FOREIGN KEY (director_id) REFERENCES directors (director_id) ON DELETE CASCADE,
    CONSTRAINT fk_director_films2 FOREIGN KEY (film_id) REFERENCES films (film_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS users
(
    user_id  BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    email    VARCHAR(30) NOT NULL,
    login    VARCHAR(30) NOT NULL,
    name     VARCHAR(30),
    birthday DATE
);

CREATE TABLE IF NOT EXISTS likes
(
    user_id BIGINT,
    film_id BIGINT,
    CONSTRAINT pk_likes PRIMARY KEY (user_id, film_id),
    CONSTRAINT fk_films FOREIGN KEY (film_id) REFERENCES films (film_id),
    CONSTRAINT fk_users FOREIGN KEY (user_id) REFERENCES users (user_id)

);

CREATE TABLE IF NOT EXISTS genres
(
    genre_id INT GENERATED BY DEFAULT AS IDENTITY NOT NULL PRIMARY KEY,
    name     VARCHAR(50)                          NOT NULL
);

CREATE TABLE IF NOT EXISTS films_genres
(
    film_id  BIGINT NOT NULL,
    genre_id INT    NOT NULL,
    CONSTRAINT pk_films_genres PRIMARY KEY (film_id, genre_id),
    CONSTRAINT fk_films_genres1 FOREIGN KEY (film_id) REFERENCES films (film_id),
    CONSTRAINT fk_films_genres2 FOREIGN KEY (genre_id) REFERENCES genres (genre_id)
);

CREATE TABLE IF NOT EXISTS friends
(
    friend_id BIGINT NOT NULL,
    user_id   BIGINT NOT NULL,
    CONSTRAINT pk_friends PRIMARY KEY (user_id, friend_id),
    CONSTRAINT fk_friends1 FOREIGN KEY (user_id) REFERENCES users (user_id),
    CONSTRAINT fk_friends2 FOREIGN KEY (friend_id) REFERENCES users (user_id)
);

CREATE TABLE IF NOT EXISTS feeds
(
    feed_id    BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    user_id    BIGINT NOT NULL,
    timestamp  TIMESTAMP,
    event_type VARCHAR(10),
    operation  VARCHAR(10),
    event_id   BIGINT NOT NULL,
    entity_id  BIGINT NOT NULL,
    CONSTRAINT fk_friends3 FOREIGN KEY (user_id) REFERENCES users (user_id)
);

CREATE TABLE IF NOT EXISTS film_reviews
(
    review_id   BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY, --идентификатор отзыва
    film_id     BIGINT,                                              --ссылка на фильм
    user_id     BIGINT,                                              --ссылка на автора отзыва
    content     VARCHAR(256) NOT NULL,                               --отзыв
    is_positive INTEGER      NOT NULL,                               --0 негативный/1 положительный
    useful      INTEGER      NOT NULL DEFAULT 0,                     --рейтинг полезности
    CONSTRAINT fk_films1 FOREIGN KEY (film_id) REFERENCES films (film_id) ON DELETE CASCADE,
    CONSTRAINT fk_users1 FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS review_likes
(
    review_id   BIGINT  NOT NULL, --ссылка на отзыв
    user_id     BIGINT  NOT NULL, --ссылка на автора лайка
    is_positive INTEGER NOT NULL, --0 дизлайк/1 лайк
    CONSTRAINT fk_film_reviews FOREIGN KEY (review_id) REFERENCES film_reviews (review_id) ON DELETE CASCADE,
    CONSTRAINT fk_users2 FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE
);