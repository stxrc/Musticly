using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Parallax : MonoBehaviour {

	public Transform[] backgrounds;
	private float[] parallaxScales;
	public float smoothing; //above 0 please
	public Transform  camera;
	private Vector3 prevCamPos;
	//called before start
	void Awake() {
		//camera = Camera.main.transform;
	}
	// Use this for initialization
	void Start () {
		smoothing = 1.5f;
		prevCamPos = camera.position;
		parallaxScales = new float[backgrounds.Length];

		for (int i = 0; i < backgrounds.Length; i++) {
			parallaxScales [i] = backgrounds [i].position.z * -1;
		}
	}
	
	// Update is called once per frame
	void Update () {
		for (int i = 0; i < backgrounds.Length; i++) {
			float parallax = (prevCamPos.x - camera.position.x) * parallaxScales [i];

			float backgroundTargetPosX = backgrounds[i].position.x + parallax;

			Vector3 backgroundTargetPos = new Vector3 (backgroundTargetPosX, backgrounds[i].position.y, backgrounds[i].position.z);

			backgrounds [i].position = Vector3.Lerp (backgrounds[i].position, backgroundTargetPos, smoothing*3 * Time.deltaTime);
		}

		prevCamPos = camera.position;
	}
}
