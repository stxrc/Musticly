using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MusicPlayer : MonoBehaviour {


    public AudioSource source;
	// Use this for initialization
	void Start () {
        source.Play();
	}
}
