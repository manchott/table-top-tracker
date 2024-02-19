package com.manchott.TTT.domain.game;

import com.manchott.TTT.domain.game.dto.SaveGameDto;
import com.manchott.TTT.domain.game.entity.Game;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class GameService {
    private final GameRepository gameRepository;

    public Game saveGame(SaveGameDto saveGameDto){
        Game game = saveGameDto.toEntity();
        gameRepository.save(game);
        return game;
    }






}
