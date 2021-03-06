package controllers;

import dao.WorldDao;
import model.World;

import java.util.concurrent.ThreadLocalRandom;

import ninja.Result;
import ninja.Results;

import com.google.inject.Inject;
import com.google.inject.Singleton;
import ninja.jpa.UnitOfWork;
import ninja.params.Param;

@Singleton
public class HelloDbController {

    private static final int DB_ROWS = 10000;

    @Inject
    WorldDao worldDao;

    @UnitOfWork
    public Result singleGet() {
        return Results.json().render(getRandomWorld());
    }

    @UnitOfWork
    public Result multiGet(@Param("queries") Integer queries) {
        if (queries == null || queries < 1) {
            queries = 1;
        }
        if (queries > 500) {
            queries = 500;
        }

        final World[] worlds = new World[queries];

        for (int i = 0; i < queries; i++) {
            worlds[i] = getRandomWorld();
        }

        return Results.json().render(worlds);
    }

    @UnitOfWork
    public Result update(@Param("queries") Integer queries) {
        if (queries == null || queries < 1) {
            queries = 1;
        }
        if (queries > 500) {
            queries = 500;
        }

        final World[] worlds = new World[queries];

        for (int i = 0; i < queries; i++) {
            worlds[i] = getRandomWorld();
        }

        // now update stuff:
        for (World world : worlds) {
            world.randomNumber = ThreadLocalRandom.current().nextInt(DB_ROWS) + 1;
            worldDao.put(world);
        }

        return Results.json().render(worlds);
    }

    private World getRandomWorld() {
        return worldDao.get(ThreadLocalRandom.current().nextInt(DB_ROWS) + 1);
    }

}
