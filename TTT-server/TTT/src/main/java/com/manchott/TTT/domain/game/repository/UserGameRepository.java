package com.manchott.TTT.domain.game.repository;

import com.manchott.TTT.domain.game.entity.Game;
import com.manchott.TTT.domain.game.entity.UserGame;
import org.springframework.data.domain.Page;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserGameRepository extends JpaRepository<UserGame, Long> {
    List<UserGame> getUserGamesByUser_UserId(Long userId);


}
