package com.manchott.TTT.domain.game.repository;

import com.manchott.TTT.domain.game.entity.Game;
import org.springframework.data.jpa.repository.JpaRepository;

public interface GameRepository extends JpaRepository<Game, Long> {
}