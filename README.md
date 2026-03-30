# Ruby RPG Game Template

A workshop template repo for building games with the [ruby_rpg](https://github.com/rubyrpg/ruby_rpg) engine. Contains multiple partially-built game templates for attendees to fill in the blanks.

## Setup

```bash
bundle install
bundle exec import .
```

## Run

Pick a template and run it:

```bash
bundle exec ruby showcase.rb
bundle exec ruby simon_says.rb
bundle exec ruby farming.rb
bundle exec ruby car_track.rb
```

Press **Escape** to quit. Use **WASD** to move, **mouse** to look, **Q/E** for up/down, **Shift** to sprint.

## Templates

| Template | Description |
|----------|-------------|
| **Showcase** | Demonstrates engine features: lighting, post-processing, models |
| **Simon Says** | Memory/pattern game |
| **Farming** | Fields, crops, and plants |
| **Car Track** | Racing/driving |

## Project Structure

```
showcase.rb / simon_says.rb / farming.rb / car_track.rb   # entry points
showcase/ simon_says/ farming/ car_track/                  # per-game code
components/                                                # shared components
assets/
  animals/       buildings/      geometry/       indicators/
  food/          nature/         props/          vehicles/
  textures/
```

## Included Assets

All assets are licensed under [CC0 1.0](https://creativecommons.org/publicdomain/zero/1.0/) (public domain, no attribution required).

Load any model with:
```ruby
Engine::Mesh.for("assets/CATEGORY/MODEL_NAME")
```

### Kenney Prototype Kit

145 low-poly 3D models from the [Kenney Prototype Kit](https://kenney.nl/assets/prototype-kit). Spread across `animals/`, `buildings/`, `geometry/`, `indicators/`, `props/`, and `vehicles/`.

| Category | Folder | Models |
|----------|--------|--------|
| **Buildings** | `buildings/` | `wall` (+ low, diagonal, round, corner, doorway, window variants), `floor` (square, diagonal, thick + variants), `column` (+ rounded, triangle, low variants), `stairs` (+ narrow, small, diagonal variants), `door` (rotate, sliding, garage variants), `pipe` (+ corner, half, section, split) |
| **Geometry** | `geometry/` | `shape-cube`, `shape-cube-half`, `shape-cube-rounded`, `shape-cylinder`, `shape-hexagon`, `shape-hollow-cylinder`, `shape-hollow-hexagon` (+ half, detailed variants), `shape-slope`, `shape-triangular-prism` |
| **Animals** | `animals/` | `animal-bison`, `animal-dog`, `animal-horse` |
| **Vehicles** | `vehicles/` | `vehicle`, `vehicle-convertible` |
| **Props** | `props/` | `crate`, `crate-color`, `coin`, `flag`, `figurine` (+ variants), `ladder` (+ color, top), `weapon-sword`, `weapon-shield`, `hat-cap`, `hat-hard`, `wheelchair` |
| **Indicators** | `indicators/` | `indicator-round-a` through `f`, `indicator-square-a` through `f`, `indicator-special-*`, `target-*`, `button-floor-*`, `lever-single`, `lever-double`, `number-0` through `9`, `number-double-0` through `9` |

### Kenney Food Kit

200 low-poly 3D models from the [Kenney Food Kit](https://kenney.nl/assets/food-kit). Stored in `food/`.

| Category | Models |
|----------|--------|
| **Vegetables** | `carrot`, `broccoli`, `cabbage`, `cauliflower`, `celery-stick`, `corn`, `eggplant`, `leek`, `mushroom`, `onion`, `paprika`, `pepper`, `pumpkin`, `radish`, `tomato`, `beet` |
| **Fruits** | `apple`, `avocado`, `banana`, `cherries`, `coconut`, `grapes`, `lemon`, `orange`, `pear`, `pineapple`, `strawberry`, `watermelon` |
| **Prepared food** | `burger`, `hot-dog`, `pizza`, `taco`, `sushi-*`, `maki-*`, `sandwich`, `sub`, `fries`, `pancakes`, `waffle`, `turkey`, `whole-ham`, `fish` |
| **Baked goods** | `bread`, `loaf`, `croissant`, `donut`, `cake`, `cupcake`, `muffin`, `cookie`, `pie`, `ginger-bread` |
| **Drinks** | `soda`, `cup-coffee`, `cup-tea`, `cocktail`, `frappe`, `glass-wine`, `wine-red`, `wine-white` |
| **Kitchen** | `frying-pan`, `pot`, `cutting-board`, `cooking-knife`, `cooking-fork`, `cooking-spatula`, `cooking-spoon`, `plate`, `bowl`, `mug`, `utensil-*` |

### Kenney Nature Kit

329 low-poly 3D models from the [Kenney Nature Kit](https://kenney.nl/assets/nature-kit). Stored in `nature/`.

| Category | Models |
|----------|--------|
| **Crops** | `crop_carrot`, `crop_melon`, `crop_pumpkin`, `crop_turnip`, `crops_corn` (stages A–D), `crops_wheat` (stages A–B), `crops_bamboo` (stages A–B), `crops_leafs` (stages A–B), `crops_dirt*` (row, corner, end, single, double variants) |
| **Trees** | `tree_default`, `tree_oak`, `tree_tall`, `tree_thin`, `tree_fat`, `tree_simple`, `tree_small`, `tree_detailed`, `tree_cone`, `tree_blocks`, `tree_plateau`, `tree_palm` (+ variants), `tree_pine*` (many variants). Most have `_dark` and `_fall` colour variants |
| **Plants** | `plant_bush` (+ detailed, large, small, triangle variants), `plant_flat*`, `flower_purple*`, `flower_red*`, `flower_yellow*`, `grass`, `grass_large`, `grass_leafs`, `mushroom_red*`, `mushroom_tan*`, `cactus_short`, `cactus_tall` |
| **Terrain** | `cliff_*` (rock + stone variants), `rock_*` (large, small, tall, flat variants), `stone_*` (large, small, tall, flat variants), `platform_*` (beach, grass, stone) |
| **Ground tiles** | `ground_grass`, `ground_path*` (bend, corner, cross, end, open, rocks, side, split, straight, tile), `ground_river*` (same variants) |
| **Structures** | `bridge_*` (stone, wood, round variants + center, side pieces), `fence_*` (bend, corner, gate, planks, simple variants), `path_stone*`, `path_wood*`, `sign`, `statue_*` |
| **Camping** | `tent_*` (detailed, small + open/closed), `campfire_*` (bricks, logs, planks, stones), `canoe`, `canoe_paddle`, `bed`, `bed_floor`, `log`, `log_large`, `log_stack`, `pot_large`, `pot_small` |

### Ground Textures

Normal map from [ambientCG Tiles 002](https://ambientcg.com/view?id=Tiles002), licensed under [CC0 1.0](https://creativecommons.org/publicdomain/zero/1.0/).
