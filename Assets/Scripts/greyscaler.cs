using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class greyscaler : MonoBehaviour {


    private Renderer renderer;

    private void Start()
    {
        renderer = GetComponent<Renderer>();
    }
    // Update is called once per frame
    void Update()
    {
        renderer.material.SetFloat("_EffectAmount", LevelManager.Instance.greyscale);
    }
}
