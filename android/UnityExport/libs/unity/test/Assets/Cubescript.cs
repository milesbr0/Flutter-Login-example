using UnityEngine;

public class Cubescript : MonoBehaviour
{

    // Update is called once per frame
    void Update()
    {
        gameObject.transform.Rotate(-0.25f, -0.25f, -0.25f, Space.World);
        gameObject.GetComponent<MeshRenderer>().material.color = new Color(Random.Range(5,100) * Time.deltaTime, Random.Range(50, 150) * Time.deltaTime, Random.Range(180, 255) * Time.deltaTime);

    }
}
