require "ruby_rpg"
require_relative "components/camera_controller"
require_relative "components/bob_and_spin"
require_relative "scenery"
require_relative "props"

AMBIENT_STRENGTH = 0.75

Engine.start do
  Rendering::PostProcessingEffect.add(
    Rendering::PostProcessingEffect.ssao(power: 1.4)
  )
  Rendering::PostProcessingEffect.add(
    Rendering::PostProcessingEffect.ssr(max_ray_distance: 15.0, ray_offset: 0.05, thickness: 1.0)
  )
  Rendering::PostProcessingEffect.add(
    Rendering::PostProcessingEffect.bloom(blur_scale: 3.0)
  )
  Engine::GameObject.create(
    name: "Camera",
    pos: Vector[0, 1, 8],
    rotation: Vector[0, 0, 0],
    components: [
      Engine::Components::PerspectiveCamera.create(fov: 45.0, aspect: 1920.0 / 1080.0, near: 0.1, far: 50.0),
      CameraController.create
    ])

  Scenery.create
  Props.create_platform
  Props.create_light_display
  Props.create_shapes_gallery
  Props.create_building
  Props.create_bloom_spheres

end
