# Ruby RPG Game Template

A starter template for building games with the [ruby_rpg](https://github.com/rubyrpg/ruby_rpg) engine.

## Setup

```bash
bundle install
bundle exec import .
```

## Run

```bash
bundle exec ruby game.rb
```

Press **Escape** to quit. Use **WASD** to move, **mouse** to look, **Q/E** for up/down, **Shift** to sprint.

## Included Assets

### Kenney Prototype Kit

145 low-poly 3D models from the [Kenney Prototype Kit](https://kenney.nl/assets/prototype-kit), licensed under [CC0 1.0](https://creativecommons.org/publicdomain/zero/1.0/) (public domain, no attribution required).

| Category | Models |
|----------|--------|
| **Walls** | `wall`, `wall-low`, `wall-diagonal`, `wall-round`, `wall-corner`, `wall-corner-rounded` (+ low variants), `wall-doorway` (regular, garage, round, sliding, wide, wide-sliding), `wall-window` (small, medium, large + barred, cutout variants) |
| **Floors** | `floor-square`, `floor-diagonal`, `floor-small-square`, `floor-small-diagonal`, `floor-thick` (+ corner variants) |
| **Columns** | `column`, `column-rounded`, `column-triangle` (+ low variants) |
| **Stairs** | `stairs`, `stairs-narrow`, `stairs-small`, `stairs-small-narrow`, `stairs-diagonal`, `stairs-diagonal-narrow`, `stairs-diagonal-small`, `stairs-diagonal-small-narrow` |
| **Shapes** | `shape-cube`, `shape-cube-half`, `shape-cube-rounded`, `shape-cylinder`, `shape-cylinder-half`, `shape-hexagon`, `shape-hexagon-half`, `shape-hollow-cylinder`, `shape-hollow-hexagon` (+ half, detailed variants), `shape-slope`, `shape-triangular-prism` |
| **Doors** | `door-rotate`, `door-sliding`, `door-sliding-double`, `door-sliding-double-round`, `door-sliding-double-wide`, `door-garage` |
| **Props** | `crate`, `crate-color`, `coin`, `flag`, `ladder`, `ladder-color`, `ladder-top`, `lever-single`, `lever-double`, `pipe`, `pipe-corner`, `pipe-half`, `pipe-half-section`, `pipe-section`, `pipe-split` |
| **Characters** | `figurine`, `figurine-large`, `figurine-cube`, `figurine-cube-detailed`, `animal-bison`, `animal-dog`, `animal-horse`, `wheelchair` |
| **Vehicles** | `vehicle`, `vehicle-convertible` |
| **Combat** | `weapon-sword`, `weapon-shield` |
| **Accessories** | `hat-cap`, `hat-hard` |
| **Markers** | `indicator-round-a` through `f`, `indicator-square-a` through `f`, `indicator-special-area`, `indicator-special-arrow`, `indicator-special-cross`, `indicator-special-lines`, `target-a-round`, `target-a-square`, `target-b-round`, `target-b-square` |
| **Numbers** | `number-0` through `9`, `number-double-0` through `9` |
| **Buttons** | `button-floor-round`, `button-floor-round-small`, `button-floor-square`, `button-floor-square-small` |
| **Textures** | `colormap.png`, `variation-a.png`, `variation-b.png`, `variation-c.png` |

Load any model with:
```ruby
Engine::Mesh.for("assets/models/MODEL_NAME")
```

### Ground Textures

Normal map from [ambientCG Tiles 002](https://ambientcg.com/view?id=Tiles002), licensed under [CC0 1.0](https://creativecommons.org/publicdomain/zero/1.0/).
