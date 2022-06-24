package ru.yandex.practicum.filmorate.service.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import ru.yandex.practicum.filmorate.model.User;
import ru.yandex.practicum.filmorate.storage.UserStorage;

import java.util.Collection;
import java.util.Optional;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    public UserServiceImpl(@Qualifier("UserDaoImpl") UserStorage storage) {
        this.storage = storage;
    }

    private UserStorage storage;

    @Override
    public Collection<User> findAll() {
        return storage.findAll();
    }

    @Override
    public Optional<User> findById(Long id) {
        return storage.findById(id);
    }

    @Override
    public Optional<User> createUser(User user) {
        if (user.getName().isEmpty()) {
            user.setName(user.getLogin());
        }
        storage.addUser(user);

        return Optional.of(user);
    }

    @Override
    public Optional<User> updateUser(User user) {
        if (user.getName().isEmpty()) {
            user.setName(user.getLogin());
        }
        return storage.updateUser(user);
    }

    @Override
    public void addFriend(Long id, Long friendId) {
        User friend = storage.findById(friendId).get();
        User user = storage.findById(id).get();
        user.addFriend(friend);
        storage.updateUser(user);
//        storage.findById(id).get().addFriend(friend);
    }

    @Override
    public void removeFriend(Long id, Long userId) {
        User user = storage.findById(id).get();
        user.getFriends().remove(userId);
        storage.updateUser(user);

    }

    @Override
    public Collection<User> getFriends(Long id) {
        return storage.getUserFriends(id);
    }

    @Override
    public Collection<User> getCrossFriends(Long id, Long otherId) {
        return storage.getUserCrossFriends(id, otherId);
    }
}
